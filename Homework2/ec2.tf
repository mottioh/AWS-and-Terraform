resource "aws_security_group" "web1" { # allow port 22 and 80 access
  name = "Nginx Aceess"
  description = "allow ssh and nginx access"
  vpc_id      = aws_vpc.default.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
    }

    filter {
      name   = "virtualization-type"
      values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}
resource "aws_instance" "web" {
    count = 2

    ami     = data.aws_ami.ubuntu.id
    instance_type = var.machine_type

    associate_public_ip_address = true

    subnet_id = aws_subnet.public[count.index].id
    user_data = file("./install_nginx.sh")

    security_groups = [aws_security_group.web1.id]
    key_name        = var.key_pair

    tags = {
      Name = "web0${count.index}"
      Purpuse = "Web"
    }
  }
resource "aws_instance" "db" {
    count                       = 2
    ami                         = data.aws_ami.ubuntu.id
    instance_type               = var.machine_type
    associate_public_ip_address = false
    subnet_id                   = aws_subnet.private[count.index].id
    key_name                    = var.key_pair
    security_groups = [aws_security_group.web1.id]

    tags = {
      Name = "db${count.index}"
    }
}
