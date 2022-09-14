resource "aws_instance" "ansible-ec2" {
  ami             = "ami-005e54dee72cc1d00" 
  instance_type   = var.instance_type
  security_groups = [aws_security_group.sg.id]

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

resource "aws_security_group" "sg" {
  name        = "allow_ssh_http"
  description = "Allow ssh http inbound traffic"
  vpc_id      = aws_vpc.app_vpc.id

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