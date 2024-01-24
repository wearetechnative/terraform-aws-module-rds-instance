variable "name" {
  description = "Unique name for RDS instance."
  type        = string
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

variable "auto_minor_version_upgrade" {
  description = "Allow minor updates during maintenance window."
  type        = bool
  default     = true
}

variable "enabled_cloudwatch_logs_exports" {
  description = "Enabled CloudWatch log exports."
  type        = list(string)
  default     = ["audit", "error", "general", "slowquery"]
}

variable "db_name_enabled" {
  description = "Default DB name to be enabled or not."
  type        = bool
  default     = false
}

variable "db_name" {
  description = "Name of the database to create when the DB instance is created."
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
  default     = "03:00-04:00"
}

variable "backup_retention_period" {
  description = "number of days to retain backups"
  default     = 35
}

variable "enable_aws_backup_tag" {
  description = "To enable aws backup service tag to RDS instance."
  type        = bool
  default     = "False"
}

variable "enable_aws_backup_tag_replica" {
  description = "To enable aws backup service tag to RDS replica instance."
  type        = bool
  default     = "False"
}
