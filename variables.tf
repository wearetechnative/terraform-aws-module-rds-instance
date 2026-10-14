variable "name" {
  description = "Unique name for RDS instance."
  type        = string
}

variable "identifier" {
  description = "Optional complete RDS DB instance identifier. Defaults to <name>-master."
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "Required list of subnets to launch instances in."
  type        = list(string)
}

variable "security_group_ids" {
  description = "Provide at least one security group to be associated with this instance."
  type        = list(string)
}

variable "instance_class" {
  description = "Instance class to be used for database instance."
  type        = string
  default     = "db.t3.medium"
}

variable "multi_az" {
  description = "Use 2 AZs for high availability."
  type        = bool
  default     = true
}

variable "storage_type" {
  description = "Storage type to be used for instances."
  type        = string
  default     = "gp2"
}

variable "storage_io1_iops" {
  description = "Overrides storage_type to io1 if set and defines the provisioned iops required."
  type        = number
  default     = null # use storage_type by default
}

variable "allocated_storage" {
  description = "Set the amount of storage to be used by RDS."
  type        = number
  default     = 20 # initial default for allocated_storage
}

variable "max_allocated_storage" {
  description = "Set the maximum storage to be used by RDS."
  type        = number
  default     = 20 # initial default for allocated_storage
}

variable "port" {
  description = "Port on which the database accepts connections. Uses the engine default when null."
  type        = number
  default     = null
}

variable "auto_minor_version_upgrade" {
  description = "Allow minor updates during maintenance window."
  type        = bool
  default     = true
}

variable "enabled_cloudwatch_logs_exports" {
  description = "Enabled CloudWatch log exports. Defaults to the existing MariaDB/MySQL exports for those engines and no exports for other engines."
  type        = list(string)
  default     = null
}

variable "db_name" {
  description = "Name of the database to create when the DB instance is created."
  type        = string
  default     = null
}

variable "snapshot_identifier" {
  description = "DB snapshot identifier or ARN to restore. When set, the database name, master credentials, character sets, and storage encryption settings are inherited from the snapshot."
  type        = string
  default     = null
}

variable "engine" {
  description = "RDS database engine to use."
  type        = string
  default     = "mariadb"
}

variable "engine_version" {
  description = "RDS database engine version to use."
  type        = string
  default     = "10.5.12"
}

variable "engine_major_version" {
  description = "RDS database engine version to use for option group."
  type        = string
  default     = "10.5"
}

variable "engine_family" {
  description = "RDS database parameter group family."
  type        = string
  default     = "mariadb10.5"
}

variable "license_model" {
  description = "RDS license model, for example license-included or bring-your-own-license."
  type        = string
  default     = null
}

variable "character_set_name" {
  description = "Database character set. This can only be set when the DB instance is created."
  type        = string
  default     = null
}

variable "nchar_character_set_name" {
  description = "National character set for Oracle DB instances. This can only be set when the DB instance is created."
  type        = string
  default     = null
}

variable "ca_cert_identifier" {
  description = "Identifier of the CA certificate for the DB instance."
  type        = string
  default     = null
}

variable "iam_database_authentication_enabled" {
  description = "Enable IAM database authentication. Defaults to enabled for supported engines and disabled otherwise."
  type        = bool
  default     = null
}

variable "option_group_options" {
  description = "Options to include in the RDS option group."
  type = map(object({
    port                           = optional(number)
    version                        = optional(string)
    vpc_security_group_memberships = optional(list(string), [])
    settings                       = optional(map(string), {})
  }))
  default = {}
}

variable "db_instance_roles" {
  description = "Map of RDS feature names to IAM role ARNs to associate with the DB instance."
  type        = map(string)
  default     = {}
}

variable "parameter_group_overrides" {
  description = "Optional map of user defined parameters. The map key is the parameter name. The map contains value and apply_method as attributes."
  type = map(object({
    value        = string
    apply_method = string
  }))
  default = {}
}

variable "kms_key_arn" {
  description = "KMS key to use for encrypting RDS instances."
  type        = string
}

variable "additional_tags" {
  description = "Additional tags to be added to resources."
  type        = map(string)
  default     = {}
}

variable "replica" {
  description = "create a read replica or not"
  type        = bool
  default     = false
}

variable "az" {
  description = "specify availability zone for instance if preferred"
  type        = string
  default     = null
}

variable "az_replica" {
  description = "specify availability zone for replica instance if preferred"
  type        = string
  default     = null
}

variable "username" {
  description = "Set a username for database. If set to null, a random username will be created"
  type        = string
  default     = null
}

variable "password" {
  description = "Set a password for username. If set to null, a random password will be created"
  type        = string
  default     = null
}

variable "backup_window" {
  description = "Add a window in the folling format: 03:00-04:00"
  type        = string
  default     = "03:00-04:00"
}

variable "backup_retention_period" {
  description = "number of days to retain backups"
  type        = number
  default     = 35
}

variable "enable_aws_backup_tag" {
  description = "To enable aws backup service tag to RDS instance."
  type        = bool
  default     = false
}

variable "enable_aws_backup_tag_replica" {
  description = "To enable aws backup service tag to RDS replica instance."
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "protect the instance from deletion"
  type        = bool
  default     = false
}

variable "copy_tags_to_snapshot" {
  description = "Copy DB instance tags to snapshots."
  type        = bool
  default     = false
}

variable "maintenance_window" {
  description = "maintenance window for rds instance updates"
  type        = string
  default     = "Sun:02:00-Sun:03:00"
}

variable "performance_insights_enabled" {
  description = "performance insights"
  default     = false
  type        = bool
}

variable "performance_insights_retention_period" {
  description = "Retention period of performance insights data"
  default     = 31
  type        = number
}

variable "monitoring_interval" {
  description = "Enhanced Monitoring interval in seconds. Set to 0 to disable Enhanced Monitoring."
  type        = number
  default     = 60

  validation {
    condition     = contains([0, 1, 5, 10, 15, 30, 60], var.monitoring_interval)
    error_message = "monitoring_interval must be one of 0, 1, 5, 10, 15, 30, or 60."
  }
}
