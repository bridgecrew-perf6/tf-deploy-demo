<!-- BEGIN_TF_DOCS -->
## Providers

The following providers are used by this module:

- <a name="provider_aws"></a> [aws](#provider\_aws)

## Required Inputs

The following input variables are required:

### <a name="input_environment"></a> [environment](#input\_environment)

Description: n/a

Type: `string`

### <a name="input_load_balancer_certificate_arn"></a> [load\_balancer\_certificate\_arn](#input\_load\_balancer\_certificate\_arn)

Description: n/a

Type: `string`

### <a name="input_load_balancer_security_groups"></a> [load\_balancer\_security\_groups](#input\_load\_balancer\_security\_groups)

Description: n/a

Type: `list(any)`

### <a name="input_load_balancer_subnets"></a> [load\_balancer\_subnets](#input\_load\_balancer\_subnets)

Description: n/a

Type: `list(any)`

### <a name="input_project_name"></a> [project\_name](#input\_project\_name)

Description: n/a

Type: `string`

### <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id)

Description: n/a

Type: `string`

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_load_balancer_dns_name"></a> [load\_balancer\_dns\_name](#output\_load\_balancer\_dns\_name)

Description: Hostname of app load balancer
<!-- END_TF_DOCS -->