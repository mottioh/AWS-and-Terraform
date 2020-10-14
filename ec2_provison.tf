provider "aws" {
  profile = "default"
  region  = "us-east-2"
}
resource "aws_instance" "example" {
  count=2 #will create 2 ec2 instnce
  ami = "ami-027cab9a7bf0155df"
  instance_type = "t2.medium"
  key_name = "moti1" # pair the public key
  user_data = file("./install_nginx.sh")
  security_groups = [aws_security_group.ngin.name]
  tags={
   Name = "Server ${count.index}" # iterating and setting the ec2 name
   Owner = "Moti"
   Purpose = "learning"
  }
    ebs_block_device{#crete additional disk
    device_name           = "/dev/sdf"
    volume_type           = "gp2"
    volume_size           = 10
    encrypted             = true
  }
}
resource "aws_security_group" "ngin" { # allow port 22 and 80 access
  name = "school"
  description = "allow ssh and nginx access"
  ingress{
    from_port = 22
    to_port = 22
    protocol= "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
}
}
