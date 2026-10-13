resource "aws_db_option_group" "this" {
  name_prefix = "${var.name}-"

  engine_name          = var.engine
  major_engine_version = var.engine_major_version

  dynamic "option" {
    for_each = var.option_group_options

    content {
      option_name                    = option.key
      port                           = option.value.port
      version                        = option.value.version
      vpc_security_group_memberships = option.value.vpc_security_group_memberships

      dynamic "option_settings" {
        for_each = option.value.settings

        content {
          name  = option_settings.key
          value = option_settings.value
        }
      }
    }
  }
}
