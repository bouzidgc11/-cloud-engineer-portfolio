variable "public_key" {
  type        = string
  description = "cle pour ce connecter public"
}

variable "db_password" {
  description = "mot de passse RDS"
  type        = string
  sensitive   = true
}