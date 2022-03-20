# aws-container-registry

Terraform module for setting up an ecs cluster for a web app

<!-- BEGIN_TF_DOCS -->
## Providers

The following providers are used by this module:

- <a name="provider_aws"></a> [aws](#provider\_aws) (4.0.0)

## Required Inputs

The following input variables are required:

### <a name="input_app_security_groups"></a> [app\_security\_groups](#input\_app\_security\_groups)

Description: n/a

Type: `list(any)`

### <a name="input_app_subnets"></a> [app\_subnets](#input\_app\_subnets)

Description: n/a

Type: `list(any)`

### <a name="input_environment"></a> [environment](#input\_environment)

Description: n/a

Type: `string`

### <a name="input_load_balancer_target_group"></a> [load\_balancer\_target\_group](#input\_load\_balancer\_target\_group)

Description: n/a

Type: `string`

### <a name="input_project_name"></a> [project\_name](#input\_project\_name)

Description: n/a

Type: `string`

### <a name="input_repository_url"></a> [repository\_url](#input\_repository\_url)

Description: n/a

Type: `string`

### <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id)

Description: n/a

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_cpu"></a> [cpu](#input\_cpu)

Description: n/a

Type: `number`

Default: `512`

### <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables)

Description: n/a

Type: `map(any)`

Default: `{}`

### <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count)

Description: n/a

Type: `number`

Default: `2`

### <a name="input_memory"></a> [memory](#input\_memory)

Description: n/a

Type: `number`

Default: `1024`

### <a name="input_secrets"></a> [secrets](#input\_secrets)

Description: n/a

Type: `map(any)`

Default: `{}`

### <a name="input_task_runner_command"></a> [task\_runner\_command](#input\_task\_runner\_command)

Description: n/a

Type: `list(any)`

Default: `[]`

## Outputs

The following outputs are exported:

### <a name="output_task_exec_role"></a> [task\_exec\_role](#output\_task\_exec\_role)

Description: n/a

### <a name="output_task_role"></a> [task\_role](#output\_task\_role)

Description: n/a
<!-- END_TF_DOCS -->
