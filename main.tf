terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.6.2"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = var.pub_key
}

data "template_file" "user_data" {
  template = file("userdata.yaml")
}

resource "aws_instance" "app_server" {
  ami                    = var.ami_id
  instance_type          = "t4g.nano"
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.sg_my_server.id]
  user_data              = data.template_file.user_data.rendered

  tags = {
    Name = "exampleApp"
  }
}

resource "aws_security_group" "sg_my_server" {
  name        = "sg_my_server"
  description = "My Server Security Group"
  vpc_id      = data.aws_vpc.main.id  

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    description      = "Outgoing traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

data "aws_vpc" "main" {
  id = var.vpc_id
}
