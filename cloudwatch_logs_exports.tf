resource "aws_cloudwatch_log_group" "log_exports" {
  for_each = { for value in var.enabled_cloudwatch_logs_exports : value => value }
  name     = "/aws/rds/instance/${aws_db_instance.this.identifier}/${each.key}"

  retention_in_days = 60
  kms_key_id        = var.kms_key_arn

  tags = merge(var.additional_tags, {
    Name = "RDS-logs"
    Type = "RDS"
  })
}

# # see comment in KMS resource policy
# resource "aws_kms_grant" "log_exports" {
#   name              = "${aws_db_instance.this.identifier}-rdscloudwatch"
#   key_id            = var.kms_key_arn
#   grantee_principal = "logs.${data.aws_region.current.name}.amazonaws.com"
#   operations        = ["Encrypt", "Decrypt", "ReEncryptFrom", "ReEncryptTo", "GenerateDataKey", "GenerateDataKeyWithoutPlaintext", "GenerateDataKeyPair", "GenerateDataKeyPairWithoutPlaintext", "DescribeKey"]
#   # # totally untested but worth looking into
#   # constraints {
#   #   encryption_context_equals = {
#   #     aws:logs:arn = aws_cloudwatch_log_group.log_exports.arn
#   #   }
#   # }
# }
