resource "aws_db_instance" "this" {
  identifier = "${var.name}-master"

  instance_class = var.instance_class
  multi_az       = var.multi_az
  storage_type   = var.storage_type
  iops           = var.storage_io1_iops

  allocated_storage     = var.allocated_storage
  # If variable max_allocated_storage = 0; the parameter is being disabled; this option is neede if you want to change a running instance type
  # If variable max_allocated_storage has value; the value is being used;
  # If variable max_allocated_storage is not defined, the default value from variables.tf is being used
  max_allocated_storage = coalesce(
    var.max_allocated_storage != null ? (
      var.max_allocated_storage != 0 ? var.max_allocated_storage : null
    ) : null,
    var.max_allocated_storage
  )

  db_name = var.db_name != null ? var.db_name : null

  allow_major_version_upgrade = false
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade

  backup_retention_period  = var.backup_retention_period
  backup_window            = var.backup_window
  delete_automated_backups = true
  deletion_protection      = var.deletion_protection

  apply_immediately  = false
  maintenance_window = var.maintenance_window

  db_subnet_group_name            = aws_db_subnet_group.this.name
  availability_zone               = var.az
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  monitoring_interval = 60
  monitoring_role_arn = module.iam_role.role_arn

  engine         = var.engine
  engine_version = var.engine_version

  skip_final_snapshot       = false
  final_snapshot_identifier = "${var.name}-finalsnapshot"

  storage_encrypted = var.kms_key_arn != null ? true : false
  kms_key_id        = var.kms_key_arn

  option_group_name    = aws_db_option_group.this.name
  parameter_group_name = aws_db_parameter_group.this.id

  username = var.username != null ? var.username : "admin_${random_password.login_suffix.result}"
  password = var.password != null ? var.password : random_password.password.result

  # performance insights not available on some circumstances
  performance_insights_enabled = var.performance_insights_enabled
  performance_insights_kms_key_id = var.performance_insights_enabled == "true" ? var.kms_key_arn : null
  performance_insights_retention_period = var.performance_insights_enabled == "true" ? 731 : null # either 731 (2 years) or 7 days...

  # keep default
  # port =

  publicly_accessible    = false
  vpc_security_group_ids = var.security_group_ids

  # extend below when more exceptions found
  # default enable when possible
  iam_database_authentication_enabled = var.engine == "mariadb" && var.engine_major_version == "10.5" ? false : true

  # tags = merge(var.additional_tags,
  # { Type = "RDS" })

  tags = merge(var.additional_tags,
    { Type          = "RDS"
      BackupEnabled = var.enable_aws_backup_tag ? "True" : "False"
    }
  )

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_db_subnet_group" "this" {
  name_prefix = "${var.name}-"

  subnet_ids = var.subnet_ids
}

resource "random_password" "password" {

  length  = 10
  special = false # all ascii besides '.', '@', '"' and ' '
}

resource "random_password" "login_suffix" {
  length  = 5
  special = false
}

resource "aws_db_instance" "replica" {
  count      = var.replica != true ? 0 : 1
  identifier = "${var.name}-replica"

  instance_class = var.instance_class
  multi_az       = var.multi_az
  storage_type   = var.storage_type
  iops           = var.storage_io1_iops


  # If variable max_allocated_storage = 0; the parameter is being disabled; this option is neede if you want to change a running instance type
  # If variable max_allocated_storage has value; the value is being used;
  # If variable max_allocated_storage is not defined, the default value from variables.tf is being used
  max_allocated_storage = coalesce(
    var.max_allocated_storage != null ? (
      var.max_allocated_storage != 0 ? var.max_allocated_storage : null
    ) : null,
    var.max_allocated_storage
  )

  replicate_source_db = aws_db_instance.this.identifier

  backup_retention_period = 0
  skip_final_snapshot     = true
  availability_zone       = var.az_replica

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  engine         = var.engine
  engine_version = var.engine_version

  storage_encrypted = var.kms_key_arn != null ? true : false
  kms_key_id        = var.kms_key_arn


  # performance insights not available on some circumstances
  performance_insights_enabled = var.performance_insights_enabled
  performance_insights_kms_key_id = var.performance_insights_enabled == "true" ? var.kms_key_arn : null
  performance_insights_retention_period = var.performance_insights_enabled == "true" ? 731 : null # either 731 (2 years) or 7 days...

  # keep default
  # port =

  publicly_accessible    = false
  vpc_security_group_ids = var.security_group_ids

  # extend below when more exceptions found
  # default enable when possible
  iam_database_authentication_enabled = var.engine == "mariadb" && var.engine_major_version == "10.5" ? false : true

  tags = merge(var.additional_tags,
    { Type          = "RDS"
      BackupEnabled = var.enable_aws_backup_tag_replica ? "True" : "False"
    }
  )

  lifecycle {
    prevent_destroy = true
  }
}