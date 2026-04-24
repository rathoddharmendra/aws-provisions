terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.41.0"
    }
  }
}

provider "aws" {
  # Configuration options
    region = "eu-central-1"
    shared_credentials_files = ["~/.aws/credentials"]
    profile                  = "sheral"
}

variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
  default     = "my-tf-test-bucket-01c2"
}


resource "aws_s3_bucket" "s3_bucket_01" {
  bucket = var.bucket_name
  tags = {
    Name        = "My-bucket-01x2"
    Environment = "Dev"
  }
}

# arn:aws:s3:::dee-test-bucket-01c3

data "aws_s3_bucket" "ext-bucket-01" {
  bucket = "dee-test-bucket-01c3"
}

output "bucket_id" {
  description = "ID of the S3 bucket"
  value       = aws_s3_bucket.s3_bucket_01.id
}

locals {
  local_example = "${output.bucket_id}-${var.bucket_name}"
}

module "vpc" {
  source = "git::https://example.com/vpc.git?ref=v1.2.0"
}

# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "6.0.1"
# }

resource "aws_subnet" "main" {
  vpc_id     = module.vpc.vpc_id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
   }
 }
