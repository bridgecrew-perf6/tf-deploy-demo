# aws-network

example terraform module for setting up a rds cluster

<!-- BEGIN_TF_DOCS -->

## Providers

The following providers are used by this module:

-   <a name="provider_aws"></a> [aws](#provider_aws)

-   <a name="provider_random"></a> [random](#provider_random)

## Required Inputs

The following input variables are required:

### <a name="input_availability_zones"></a> [availability_zones](#input_availability_zones)

Description: n/a

Type: `list(string)`

### <a name="input_cluster_name"></a> [cluster_name](#input_cluster_name)

Description: n/a

Type: `string`

### <a name="input_database_name"></a> [database_name](#input_database_name)

Description: n/a

Type: `string`

### <a name="input_security_groups"></a> [security_groups](#input_security_groups)

Description: n/a

Type: `list(string)`

### <a name="input_subnet_ids"></a> [subnet_ids](#input_subnet_ids)

Description: n/a

Type: `list(string)`

### <a name="input_vpc_name"></a> [vpc_name](#input_vpc_name)

Description: n/a

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_engine_version"></a> [engine_version](#input_engine_version)

Description: n/a

Type: `string`

Default: `"13.4"`

### <a name="input_instance_class"></a> [instance_class](#input_instance_class)

Description: n/a

Type: `string`

Default: `"db.t4g.medium"`

### <a name="input_instance_count"></a> [instance_count](#input_instance_count)

Description: n/a

Type: `number`

Default: `2`

### <a name="input_username"></a> [username](#input_username)

Description: n/a

Type: `string`

Default: `"example"`

## Outputs

The following outputs are exported:

### <a name="output_database_name"></a> [database_name](#output_database_name)

Description: n/a

### <a name="output_reader_endpoint"></a> [reader_endpoint](#output_reader_endpoint)

Description: n/a

### <a name="output_secret_arn"></a> [secret_arn](#output_secret_arn)

Description: n/a

### <a name="output_writer_endpoint"></a> [writer_endpoint](#output_writer_endpoint)

Description: n/a

<!-- END_TF_DOCS -->
