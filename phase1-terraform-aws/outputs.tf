output "id_vpc" {
  value       = aws_vpc.main.id
  description = "vpc id"
}

output "ec2_public_ip" {
  value       = aws_instance.web.public_ip
  description = "adresse public IP du serveur web"
}

output "rds_endpoint" {
  value       = aws_db_instance.main.endpoint
  description = "Endpoint RDS PostgreSQL"
}