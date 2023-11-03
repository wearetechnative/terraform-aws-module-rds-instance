module "iam_role" {
  source = "git@github.com:wearetechnative/terraform-aws-iam-role.git?ref=v1.0.0"

  role_name = "rds-${var.name}-cloudwatch"
  role_path = "/rds/"

  aws_managed_policies = ["AmazonRDSEnhancedMonitoringRole"]
  # customer_managed_policies = {
  #   "AllowEFSAccess": jsondecode(data.aws_iam_policy_document.efs-access.json)
  #   "CloudWatchAgent": jsondecode(data.aws_iam_policy_document.cloudwatchagent.json)
  #   "ApplicationDataS3": jsondecode(data.aws_iam_policy_document.applicationdatas3.json)
  #   "BackupS3": jsondecode(data.aws_iam_policy_document.backups3.json)
  # }

  trust_relationship = {
    "EnhancedMonitoring" : { "identifier" : "monitoring.rds.amazonaws.com", "identifier_type" : "Service", "enforce_mfa" : false, "enforce_userprincipal" : false, "external_id" : null, "prevent_account_confuseddeputy" : false }
  }
}
