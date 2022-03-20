# aws-container-registry

Terraform module for setting up a container registry

<!-- BEGIN_TF_DOCS -->
## Providers

The following providers are used by this module:

- <a name="provider_aws"></a> [aws](#provider\_aws)

## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_mutability"></a> [mutability](#input\_mutability)

Description: n/a

Type: `string`

Default: `"IMMUTABLE"`

### <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name)

Description: n/a

Type: `string`

Default: `"main"`

### <a name="input_scan_on_push"></a> [scan\_on\_push](#input\_scan\_on\_push)

Description: n/a

Type: `bool`

Default: `true`

## Outputs

The following outputs are exported:

### <a name="output_repository_arn"></a> [repository\_arn](#output\_repository\_arn)

Description: n/a

### <a name="output_repository_url"></a> [repository\_url](#output\_repository\_url)

Description: n/a
<!-- END_TF_DOCS -->
