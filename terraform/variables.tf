variable "aws_region" {
  description = "Region for the EC2"
  default     = "us-east-1"
}

variable "Ubuntu_ami" {
  description = "Ubuntu AMI for EC2"
  default     = "ami-052efd3df9dad4825"
}

variable "instance_type" {
  description = "instance type"
  default     = "t2.large"
}
