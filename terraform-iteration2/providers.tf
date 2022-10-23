terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

# terraform {
#   required_version = ">= 1.1.7"
#   backend "s3" {
#     bucket = "devops-masterclass"
#     key    = "terraformstate/terraform.tfstate"
#     region = "eu-west-2"
#   }
# }