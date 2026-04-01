resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name      = "vpc-challenge"
    Owner     = "bouzid"
    ManagedBy = "terraform"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ca-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name      = "subnet-public-1a"
    Owner     = "bouzid"
    ManagedBy = "terraform"
  }
}
resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ca-central-1b"
  map_public_ip_on_launch = true


  tags = {
    Name      = "subnet-public-1b"
    Owner     = "bouzid"
    ManagedBy = "terraform"
  }
}
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ca-central-1a"

  tags = {
    Name      = "subnet-private-1a"
    Owner     = "bouzid"
    ManagedBy = "terraform"
  }
}
resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ca-central-1b"

  tags = {
    Name      = "subnet-private-1b"
    Owner     = "bouzid"
    ManagedBy = "terraform"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "gateway-public"
    Owner     = "bouzid"
    ManagedBy = "terraform"
  }
}

resource "aws_route_table" "routePublic" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "rt-public"
  }
}

resource "aws_route_table_association" "public_1" {

  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.routePublic.id
}

resource "aws_route_table_association" "public_2" {

  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.routePublic.id
}

