
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "infra-iac-aws-lab1"
    key            = "challenge/terraform.tfstate"
    region         = "ca-central-1"
    dynamodb_table = "infra-iac-lock"
    encrypt        = true
  }


}
provider "aws" {
  region = "ca-central-1"
}

