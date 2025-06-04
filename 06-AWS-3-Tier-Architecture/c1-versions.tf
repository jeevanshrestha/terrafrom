# Terraform Block
terraform {

  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

}

# Provider-1 for ap-southeast-2 (Default Provider)
provider "aws" {
  region  = var.aws_region
  profile = "default"
}


