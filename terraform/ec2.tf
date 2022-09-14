resource "aws_instance" "ansible" {
  ami             = "ami-052efd3df9dad4825" 
  instance_type   = "t2.mediume"
  security_groups = [aws_security_group.sg1.id]

  user_data = <<-EOF
  #!/bin/bash
    echo "*** Installing ansible"
 sudo apt update
 sudo apt install -y software-properties-common
 sudo apt-add-repository --yes --update ppa:ansible/ansible
 sudo apt install -y ansible
  echo "*** Completed Installing ansible"
  EOF

  tags = {
    Name = "web_instance"
  }

  volume_tags = {
    Name = "web_instance"
  } 
}

resource "aws_security_group" "sg1" {
  name        = "allow_ssh_http"
  description = "Allow ssh http inbound traffic"
 

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  tags = {
    Name = "allow_ssh_http"
  }
}

resource "aws_instance" "jenkins" {
  ami             = "ami-052efd3df9dad4825" 
  instance_type   = "t2.mediume"
  security_groups = [aws_security_group.sg2.id]

  tags = {
    Name = "web_instance"
  }

  volume_tags = {
    Name = "web_instance"
  } 
}

resource "aws_security_group" "sg2" {
  name        = "allow_ssh_http"
  description = "Allow ssh http inbound traffic"
 

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP from VPC"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}