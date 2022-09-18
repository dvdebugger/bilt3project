

  resource "aws_instance" "PlayMarriagenowAnsible" {
     ami                    = var.Ubuntu_ami
     instance_type          = var.instance_type
     vpc_security_group_ids = ["${aws_security_group.sgpmna.id}"]
     user_data              = file("install.sh")

     tags = {
         Name = "DebuggersPlayMarriagenowAnsible"
         } 
      }
  resource "aws_instance" "PlayMarriagenow" {
     ami                   = var.Ubuntu_ami
     instance_type          = var.instance_type
     vpc_security_group_ids = ["${aws_security_group.sgpmn.id}"]

     tags = {
         Name = "DebuggersPlayMarriagenow"
          } 
      }
   resource "aws_security_group" "sgpmna" {
      name        = "PlayMarriagenowA-SG"
     description = "Allow incoming HTTP connections & SSH access"

      ingress {
         description = "Allow incoming HTTP connections"
         from_port   = 80
         to_port     = 80
         protocol    = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
         }

     ingress {
         description = "Allow incoming SSH access"
         from_port   = 22
         to_port     = 22
         protocol    = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
         }

      egress {
         from_port   = 0
         to_port     = 0
         protocol    = "-1"
         cidr_blocks = ["0.0.0.0/0"]
         }

      tags = {
         Name = "DebuggersPlayMarriagenowASG"
         }
     }
  resource "aws_security_group" "sgpmn" {
      name        = "PlayMarriagenow-SG"
     description = "Allow incoming HTTP connections & SSH access"

     ingress {
         description = "Allow incoming HTTP connections"
         from_port   = 80
         to_port     = 80
         protocol    = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
         }

     ingress {
         description = "Allow incoming SSH access"
         from_port   = 22
         to_port     = 22
         protocol    = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
         }

      egress {
         from_port   = 0
         to_port     = 0
         protocol    = "-1"
         cidr_blocks = ["0.0.0.0/0"]
         }

      tags = {
         Name = "DebuggersPlayMarriagenowSG"
         }
       }

