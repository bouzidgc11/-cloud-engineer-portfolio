resource "aws_db_subnet_group" "main" {
  name = "db_subnet_group"
  description = "subnet group pour RDS PostgreSQ"
  subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]
   tags = {
    
    Name      = "db-subnet-group"
    ManagedBy = "terraform"
  }
}
resource "aws_db_parameter_group" "postgres" {
  name        = "postgres-params"
  family      = "postgres15"
  description = "Parameter group pour PostgreSQL 15"
  tags = {
    Name      = "postgres-params"
    ManagedBy = "terraform"
  }
}

resource "aws_db_instance" "main" {
  identifier             = "phase1-db"
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = "lab1db"
  username               = "admindb"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.sg_db.id]
  parameter_group_name   = aws_db_parameter_group.postgres.name
  skip_final_snapshot    = true
  publicly_accessible    = false
  tags = {
    Name      = "phase1-db"
    ManagedBy = "terraform"
  }
}
