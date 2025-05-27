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
    region = "ap-southeast-2"
    profile = "default"
}   

# Provider-2 for us-east-1  
provider "aws" {
  region = "us-east-1"
  profile = "default"
  alias  = "us-east-1"
}
/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/

