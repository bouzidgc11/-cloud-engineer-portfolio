data "aws_ami" "amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_key_pair" "lab_challange" {
  key_name   = "lab-challange"
  public_key = var.public_key

  tags = {
    Name      = "labchallange-key"
    ManagedBy = "terraform"
  }

}
resource "aws_instance" "web" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_1.id
  vpc_security_group_ids      = [aws_security_group.sg_web.id]
  key_name                    = aws_key_pair.lab_challange.key_name
  associate_public_ip_address = true
  user_data                   = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello depuis Terraform - Phase 1 !</h1>" > /var/www/html/index.html
  EOF
  tags = {
    Name      = "ec2-Labchallange-web"
    ManagedBy = "terraform"
  }

}