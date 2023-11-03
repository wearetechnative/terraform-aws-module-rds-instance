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