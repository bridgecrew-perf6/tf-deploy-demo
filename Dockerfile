FROM python:3-alpine
RUN apk add --no-cache gcc libressl-dev musl-dev libffi-dev libpq-dev postgresql-dev python3-dev
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["sample.py"]
EXPOSE 443