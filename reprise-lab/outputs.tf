output "ec2_public_ip" {
  description = "adresse publique du serveur web"
  value       = aws_instance.web.public_ip
}

output "identificateur_vpc" {
  description = "id du vpc"
  value       = aws_vpc.main.id
}

output "rds_endpoint" {
  description = "Endpoint de connexion RDS"
  value       = aws_db_instance.main.endpoint
}