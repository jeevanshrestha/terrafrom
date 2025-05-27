# Terraform Providers Example

This folder demonstrates how to configure Terraform providers and create a Virtual Private Cloud (VPC) using Terraform.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed
- Cloud provider credentials (e.g., AWS, Azure, GCP)

## Example: AWS VPC

Below is a sample Terraform configuration to create a VPC on AWS.

```hcl
terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
    required_version = ">= 1.0.0"
}

provider "aws" {
    region = "ap-southeast-2"
}

resource "aws_vpc" "main" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags = {
        Name = "main-vpc"
    }
}
```

## Usage

1. Initialize Terraform:

        ```sh
        terraform init
        ```
2. Validate the configuration:

        ```sh
        terraform validate
        ```
3. Review the execution plan:

        ```sh
        terraform plan
        ```

4. Apply the configuration:

        ```sh
        terraform apply
        ```
        5. Destroy the infrastructure when no longer needed:

            ```sh
            terraform destroy
            ```
## Notes

- Update the provider block and resource configuration as needed for your cloud provider.
- Refer to the [Terraform documentation](https://registry.terraform.io/) for more details on provider-specific resources.
