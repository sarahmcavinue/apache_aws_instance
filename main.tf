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
  template = ("userdata.yaml")
}

resource "aws_instance" "app_server" {
  ami                    = "ami-02df7c0eecb64fb85"
  instance_type          = "t4g.nano"
  key_name               = "${aws_key_pair.deployer.key_name}"
  vpc_security_group_ids = [aws_security_group.sg_my_server.id]
  user_data              = data.template_file.user_data.rendered
  /*
  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> /Users/Sarah/Desktop/ec2-user/private_ips.txt"
    
  }
 
  provisioner "remote-exec" {
    inline = [
    "echo ${self.private_ip} >> /home/ec2-user/private_ips.txt"
    ]
    connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = "${self.public_ip}"
    private_key = "${file("/Users/Sarah/.ssh/new_key")}"
  }

  }

  */
provisioner "file" {
    content     = "mars"
    destination = "/home/ec2-user/barsoon.txt"
    connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = "${self.public_ip}"
    private_key = "${file("/Users/Sarah/.ssh/new_key")}"
  }

  }

  tags = {
    Name = "exampleApp"
  }

}
resource "aws_security_group" "sg_my_server" {
  name        = "sg_my_server"
  description = "My Server Security Group"
  vpc_id      = data.aws_vpc.main.id  

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self = false
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["78.19.173.229/32"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self = false
  }

  egress {
    description = "out going traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    security_groups  = []
    self = false
  }

  tags = {
    Name = "allow_tls"
  }
}


data "aws_vpc" "main" {
  id = "vpc-XXXXX"
}
