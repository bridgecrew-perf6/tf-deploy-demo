from flask import Flask
import psycopg2
from psycopg2 import Error
import os

POSTGRES_USERNAME = os.environ.get("POSTGRES_USERNAME")
POSTGRES_PASSWORD = os.environ.get("POSTGRES_PASSWORD")
DB_HOST = os.environ.get("DB_WRITER_HOST")
DB_NAME = os.environ.get("DB_NAME")

app = Flask(__name__)


@app.after_request
def treat_as_plain_text(response):
    response.headers["content-type"] = "text/plain"
    return response


@app.route("/")
def hello():
    hello_string = "Hello\n"
    try:
        # Connect to an existing database
        connection = psycopg2.connect(user=POSTGRES_USERNAME,
                                      password=POSTGRES_PASSWORD,
                                      host=DB_HOST,
                                      port="5432",
                                      database=DB_NAME)

        # Create a cursor to perform database operations
        cursor = connection.cursor()
        # Print PostgreSQL details
        hello_string += "PostgreSQL server information"
        hello_string += "{} \n".format(connection.get_dsn_parameters())
        # Executing a SQL query
        cursor.execute("SELECT version();")
        # Fetch result
        record = cursor.fetchone()
        hello_string += "You are connected to - {} \n".format(record)

    except (Exception, Error) as error:
        hello_string += "Error while connecting to PostgreSQL {} \n".format(
            error)
    finally:
        if (connection):
            cursor.close()
            connection.close()
            hello_string += "PostgreSQL connection is closed"
    return hello_string


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 443))
    app.run(debug=True, host='0.0.0.0', port=port, ssl_context='adhoc')
