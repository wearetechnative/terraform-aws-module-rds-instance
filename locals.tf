locals {
  db_identifier = coalesce(var.identifier, "${var.name}-master")

  iam_database_authentication_supported_engines = toset([
    "mariadb",
    "mysql",
    "postgres",
  ])

  iam_database_authentication_enabled = coalesce(
    var.iam_database_authentication_enabled,
    var.engine == "mariadb" && var.engine_major_version == "10.5" ? false : contains(
      local.iam_database_authentication_supported_engines,
      var.engine,
    ),
  )

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports != null ? var.enabled_cloudwatch_logs_exports : (
    contains(["mariadb", "mysql"], var.engine) ? ["audit", "error", "general", "slowquery"] : []
  )

  performance_insights_available = (
    (var.instance_class == "db.t4g.micro" && var.engine == "mariadb" && var.engine_major_version == "10.5")
    || (var.instance_class == "db.t2.small" && var.engine == "mysql" && var.engine_major_version == "5.7")
  ? false : true)
}
