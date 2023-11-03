resource "aws_db_option_group" "this" {
  name_prefix = "${var.name}-"

  engine_name          = var.engine
  major_engine_version = var.engine_major_version
}
