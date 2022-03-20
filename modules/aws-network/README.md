# aws-network

example terraform module for setting up a network

<!-- BEGIN_TF_DOCS -->

## Providers

The following providers are used by this module:

-   <a name="provider_aws"></a> [aws](#provider_aws)

## Required Inputs

The following input variables are required:

### <a name="input_base_cidr_block"></a> [base_cidr_block](#input_base_cidr_block)

Description: n/a

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_enable_postgresql_access"></a> [enable_postgresql_access](#input_enable_postgresql_access)

Description: n/a

Type: `bool`

Default: `false`

### <a name="input_enable_web_app_access"></a> [enable_web_app_access](#input_enable_web_app_access)

Description: n/a

Type: `bool`

Default: `false`

### <a name="input_public_subnet_required"></a> [public_subnet_required](#input_public_subnet_required)

Description: n/a

Type: `bool`

Default: `false`

### <a name="input_vpc_name"></a> [vpc_name](#input_vpc_name)

Description: n/a

Type: `string`

Default: `"main"`

## Outputs

The following outputs are exported:

### <a name="output_availability_zones"></a> [availability_zones](#output_availability_zones)

Description: Avaiability zones for configured vpc

### <a name="output_db_security_group"></a> [db_security_group](#output_db_security_group)

Description: n/a

### <a name="output_load_balancer_security_group"></a> [load_balancer_security_group](#output_load_balancer_security_group)

Description: n/a

### <a name="output_primary_private_subnet"></a> [primary_private_subnet](#output_primary_private_subnet)

Description: Primary private subnet id

### <a name="output_primary_private_subnet_cidr"></a> [primary_private_subnet_cidr](#output_primary_private_subnet_cidr)

Description: Primary private subnet id

### <a name="output_primary_public_subnet"></a> [primary_public_subnet](#output_primary_public_subnet)

Description: Primary public subnet id

### <a name="output_primary_public_subnet_cidr"></a> [primary_public_subnet_cidr](#output_primary_public_subnet_cidr)

Description: Primary public subnet id

### <a name="output_secondary_private_subnet"></a> [secondary_private_subnet](#output_secondary_private_subnet)

Description: Secondary private subnet id

### <a name="output_secondary_private_subnet_cidr"></a> [secondary_private_subnet_cidr](#output_secondary_private_subnet_cidr)

Description: Secondary private subnet id

### <a name="output_secondary_public_subnet"></a> [secondary_public_subnet](#output_secondary_public_subnet)

Description: Secondary public subnet id

### <a name="output_secondary_public_subnet_cidr"></a> [secondary_public_subnet_cidr](#output_secondary_public_subnet_cidr)

Description: Secondary public subnet id

### <a name="output_vpc_id"></a> [vpc_id](#output_vpc_id)

Description: VPC ID

### <a name="output_vpc_name"></a> [vpc_name](#output_vpc_name)

Description: n/a

### <a name="output_web_app_security_group"></a> [web_app_security_group](#output_web_app_security_group)

Description: n/a

<!-- END_TF_DOCS -->
