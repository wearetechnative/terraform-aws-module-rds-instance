resource "aws_db_parameter_group" "this" {
  name_prefix = "${var.name}-"
  family      = var.engine_family

  dynamic "parameter" {
    for_each = var.parameter_group_overrides

    content {
      name         = parameter.key
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }
}
