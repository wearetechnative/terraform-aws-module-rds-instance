output "master_db_user_name" {
  value = aws_db_instance.this.username
}

output "master_db_user_password" {
  value = aws_db_instance.this.password
}

output "db_dns_address" {
  value = aws_db_instance.this.address
}

output "db_port" {
  value = aws_db_instance.this.port
}

output "instance_arn" {
  value = aws_db_instance.this.arn
}

output "db_name" {
  value = aws_db_instance.this.db_name
}

output "domain" {
  value = aws_db_instance.this.domain
}