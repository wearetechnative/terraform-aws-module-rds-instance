# Example is commented because linter wont accept nonexisting resource calls

# variable "kms_key_arn" {
#   type = string
# }

# variable "subnet_ids" {
#   description = "Private data subnet IDs in at least two Availability Zones."
#   type        = list(string)
# }

# variable "security_group_ids" {
#   type = list(string)
# }

# variable "s3_integration_role_arn" {
#   description = "IAM role with workload-specific S3 permissions for Oracle S3 integration."
#   type        = string
# }

# variable "snapshot_identifier" {
#   description = "Optional Oracle DB snapshot identifier or ARN to restore."
#   type        = string
#   default     = null
# }

# module "oracle" {
#   source = "../.."

#   name       = "example-oracle"
#   identifier = "example-oracle"

#   snapshot_identifier = var.snapshot_identifier

#   subnet_ids         = var.subnet_ids
#   security_group_ids = var.security_group_ids
#   kms_key_arn        = var.kms_key_arn

#   engine               = "oracle-se2-cdb"
#   engine_version       = "19.0.0.0.ru-2026-07.mrp-2026-07.r1"
#   engine_major_version = "19"
#   engine_family        = "oracle-se2-cdb-19"
#   license_model        = "license-included"

#   instance_class        = "db.m5.xlarge"
#   allocated_storage     = 2000
#   max_allocated_storage = 4000
#   storage_type          = "gp2"
#   multi_az              = false

#   db_name                  = "ORCL"
#   port                     = 1521
#   character_set_name       = "AL32UTF8"
#   nchar_character_set_name = "AL16UTF16"

#   backup_retention_period = 7
#   copy_tags_to_snapshot   = true
#   monitoring_interval     = 60
#   log_kms_key_arn = data.terraform_remote_state.kms.outputs.default_kms_key_arn
#   performance_insights_enabled          = true
#   performance_insights_retention_period = 7

#   iam_database_authentication_enabled = false
#   enabled_cloudwatch_logs_exports = [
#     "alert",
#     "audit",
#     "listener",
#     "oemagent",
#     "trace",
#   ]

#   option_group_options = {
#     JVM            = {}
#     S3_INTEGRATION = {}
#     UTL_MAIL       = {}
#   }

#   db_instance_roles = {
#     S3_INTEGRATION = var.s3_integration_role_arn
#   }
# }
