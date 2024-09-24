locals {
  performance_insights_available = (
    (var.instance_class == "db.t4g.micro" && var.engine == "mysql" && var.engine_major_version == "8.0")
    || (var.instance_class == "db.t2.small" && var.engine == "mysql" && var.engine_major_version == "5.7")
  ? false : true)
}
