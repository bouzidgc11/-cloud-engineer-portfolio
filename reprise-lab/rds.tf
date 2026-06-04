resource "aws_db_subnet_group" "main" {
  name       = "db-subnet-name"
  subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]
  tags = {
    name = "db-subnet-name"
  }
}

resource "aws_db_instance" "main" {
  identifier             = "phase1-db"
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = "phase1db"
  username               = "admindb"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db.id]
  skip_final_snapshot    = true
  publicly_accessible    = false
  tags = {
    Name      = "phase1-db"
    ManagedBy = "terraform"
  }
}