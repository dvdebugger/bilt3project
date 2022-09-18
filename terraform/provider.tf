terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

# Define AWS as a provider
provider "aws" {
  region = var.aws_region
}