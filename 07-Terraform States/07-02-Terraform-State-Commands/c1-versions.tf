# Terraform Block
terraform {

  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    } 
  }

  backend "s3" {
    bucket = "jeeves-terraform-sydney"
    key    = "state-commands/terraform.tfstate"
    region = "ap-southeast-2"

    #For State locking
    dynamodb_table = "terraform-dev-state-table"
  }

}

# Provider-1 for ap-southeast-2 (Default Provider)
provider "aws" {
  region  = "ap-southeast-2"
  profile = "default"
} 
/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/

