terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "${var.env}-${var.bucket_name}"
    key = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "${var.env}-infra-app-table"
    
  }
}