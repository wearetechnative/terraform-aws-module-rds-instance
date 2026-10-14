[![](we-are-technative.png)](https://www.technative.nl)

# Terraform AWS [terraform-aws-module-rds-instance] ![](https://img.shields.io/github/actions/workflow/status/wearetechnative/terraform-aws-module-rds-instance/lint.yaml?branch=main&style=plastic&label=lint) ![](https://img.shields.io/github/actions/workflow/status/wearetechnative/terraform-aws-module-rds-instance/security-scan.yaml?branch=main&style=plastic&label=security)

# rds_instance

Use this module for any RDS that is not Aurora. Use the rds_cluster for Aurora instances.

Known issues:

If you receive:

╷
│ Error: Creating CloudWatch Log Group failed: ResourceAlreadyExistsException: The specified log group already exists:  The CloudWatch Log Group '/aws/rds/instance/website-stack-20220819105124303000000001/error' already exists.
│
│   with module.website_stack.module.website_database.aws_cloudwatch_log_group.log_exports["error"],
│   on ../../modules/rds_instance/cloudwatch_logs_exports.tf line 1, in resource "aws_cloudwatch_log_group" "log_exports":
│    1: resource "aws_cloudwatch_log_group" "log_exports" {
│
╵

Upon initial creation then import the resource or delete it and rerun the TerraForm module. The reason this happens is because we want to control automically created CloudWatch log groups. This happens in more places in AWS unfortunately.

## Oracle support

Oracle DB instances require an explicit `license_model`. The module supports Oracle character sets, option groups, DB instance IAM role associations, and engine-specific log exports through generic inputs. IAM database authentication defaults to disabled for Oracle.

See [examples/oracle](examples/oracle) for a private Oracle SE2 CDB example. IAM roles passed through `db_instance_roles` are intentionally created outside this module because their permissions are workload-specific.

## max_allocated_storage

Set `max_allocated_storage` to `0` or `null` to disable storage autoscaling.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=4.8.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >=3.1.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.68.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.9.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_role"></a> [iam\_role](#module\_iam\_role) | github.com/wearetechnative/terraform-aws-iam-role.git | 9229bbd0280807cbc49f194ff6d2741265dc108a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.log_exports](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_db_instance.replica](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_instance_role_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance_role_association) | resource |
| [aws_db_option_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_option_group) | resource |
| [aws_db_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [random_password.login_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | Additional tags to be added to resources. | `map(string)` | `{}` | no |
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | Set the amount of storage to be used by RDS. | `number` | `20` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Allow minor updates during maintenance window. | `bool` | `true` | no |
| <a name="input_az"></a> [az](#input\_az) | specify availability zone for instance if preferred | `string` | `null` | no |
| <a name="input_az_replica"></a> [az\_replica](#input\_az\_replica) | specify availability zone for replica instance if preferred | `string` | `null` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | number of days to retain backups | `number` | `35` | no |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window) | Add a window in the folling format: 03:00-04:00 | `string` | `"03:00-04:00"` | no |
| <a name="input_ca_cert_identifier"></a> [ca\_cert\_identifier](#input\_ca\_cert\_identifier) | Identifier of the CA certificate for the DB instance. | `string` | `null` | no |
| <a name="input_character_set_name"></a> [character\_set\_name](#input\_character\_set\_name) | Database character set. This can only be set when the DB instance is created. | `string` | `null` | no |
| <a name="input_copy_tags_to_snapshot"></a> [copy\_tags\_to\_snapshot](#input\_copy\_tags\_to\_snapshot) | Copy DB instance tags to snapshots. | `bool` | `false` | no |
| <a name="input_db_instance_roles"></a> [db\_instance\_roles](#input\_db\_instance\_roles) | Map of RDS feature names to IAM role ARNs to associate with the DB instance. | `map(string)` | `{}` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Name of the database to create when the DB instance is created. | `string` | `null` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | protect the instance from deletion | `bool` | `false` | no |
| <a name="input_enable_aws_backup_tag"></a> [enable\_aws\_backup\_tag](#input\_enable\_aws\_backup\_tag) | To enable aws backup service tag to RDS instance. | `bool` | `false` | no |
| <a name="input_enable_aws_backup_tag_replica"></a> [enable\_aws\_backup\_tag\_replica](#input\_enable\_aws\_backup\_tag\_replica) | To enable aws backup service tag to RDS replica instance. | `bool` | `false` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | Enabled CloudWatch log exports. Defaults to the existing MariaDB/MySQL exports for those engines and no exports for other engines. | `list(string)` | `null` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | RDS database engine to use. | `string` | `"mariadb"` | no |
| <a name="input_engine_family"></a> [engine\_family](#input\_engine\_family) | RDS database parameter group family. | `string` | `"mariadb10.5"` | no |
| <a name="input_engine_major_version"></a> [engine\_major\_version](#input\_engine\_major\_version) | RDS database engine version to use for option group. | `string` | `"10.5"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | RDS database engine version to use. | `string` | `"10.5.12"` | no |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled) | Enable IAM database authentication. Defaults to enabled for supported engines and disabled otherwise. | `bool` | `null` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | Optional complete RDS DB instance identifier. Defaults to <name>-master. | `string` | `null` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | Instance class to be used for database instance. | `string` | `"db.t3.medium"` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | KMS key to use for encrypting RDS instances. | `string` | n/a | yes |
| <a name="input_license_model"></a> [license\_model](#input\_license\_model) | RDS license model, for example license-included or bring-your-own-license. | `string` | `null` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | maintenance window for rds instance updates | `string` | `"Sun:02:00-Sun:03:00"` | no |
| <a name="input_max_allocated_storage"></a> [max\_allocated\_storage](#input\_max\_allocated\_storage) | Set the maximum storage to be used by RDS. | `number` | `20` | no |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | Enhanced Monitoring interval in seconds. Set to 0 to disable Enhanced Monitoring. | `number` | `60` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Use 2 AZs for high availability. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Unique name for RDS instance. | `string` | n/a | yes |
| <a name="input_nchar_character_set_name"></a> [nchar\_character\_set\_name](#input\_nchar\_character\_set\_name) | National character set for Oracle DB instances. This can only be set when the DB instance is created. | `string` | `null` | no |
| <a name="input_option_group_options"></a> [option\_group\_options](#input\_option\_group\_options) | Options to include in the RDS option group. | <pre>map(object({<br/>    port                           = optional(number)<br/>    version                        = optional(string)<br/>    vpc_security_group_memberships = optional(list(string), [])<br/>    settings                       = optional(map(string), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_parameter_group_overrides"></a> [parameter\_group\_overrides](#input\_parameter\_group\_overrides) | Optional map of user defined parameters. The map key is the parameter name. The map contains value and apply\_method as attributes. | <pre>map(object({<br/>    value        = string<br/>    apply_method = string<br/>  }))</pre> | `{}` | no |
| <a name="input_password"></a> [password](#input\_password) | Set a password for username. If set to null, a random password will be created | `string` | `null` | no |
| <a name="input_performance_insights_enabled"></a> [performance\_insights\_enabled](#input\_performance\_insights\_enabled) | performance insights | `bool` | `false` | no |
| <a name="input_performance_insights_retention_period"></a> [performance\_insights\_retention\_period](#input\_performance\_insights\_retention\_period) | Retention period of performance insights data | `number` | `31` | no |
| <a name="input_port"></a> [port](#input\_port) | Port on which the database accepts connections. Uses the engine default when null. | `number` | `null` | no |
| <a name="input_replica"></a> [replica](#input\_replica) | create a read replica or not | `bool` | `false` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Provide at least one security group to be associated with this instance. | `list(string)` | n/a | yes |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | DB snapshot identifier or ARN to restore. When set, the database name, master credentials, character sets, and storage encryption settings are inherited from the snapshot. | `string` | `null` | no |
| <a name="input_storage_io1_iops"></a> [storage\_io1\_iops](#input\_storage\_io1\_iops) | Overrides storage\_type to io1 if set and defines the provisioned iops required. | `number` | `null` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | Storage type to be used for instances. | `string` | `"gp2"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Required list of subnets to launch instances in. | `list(string)` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | Set a username for database. If set to null, a random username will be created | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_dns_address"></a> [db\_dns\_address](#output\_db\_dns\_address) | n/a |
| <a name="output_db_name"></a> [db\_name](#output\_db\_name) | n/a |
| <a name="output_db_port"></a> [db\_port](#output\_db\_port) | n/a |
| <a name="output_domain"></a> [domain](#output\_domain) | n/a |
| <a name="output_instance_arn"></a> [instance\_arn](#output\_instance\_arn) | n/a |
| <a name="output_master_db_user_name"></a> [master\_db\_user\_name](#output\_master\_db\_user\_name) | n/a |
| <a name="output_master_db_user_password"></a> [master\_db\_user\_password](#output\_master\_db\_user\_password) | n/a |
| <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id) | n/a |
<!-- END_TF_DOCS -->
