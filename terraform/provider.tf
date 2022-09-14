terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.18.0"
    }
  }
}

# Define AWS as a provider
provider "aws" {
  region = "us-east-1"
}
