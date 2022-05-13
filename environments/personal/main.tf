# Uses mgoldman personal (907176488429) account

terraform {
  backend "s3" {
    encrypt = true
    bucket  = "mgoldman-tfstate-bucket"
    key     = "aws/demo.tfstate"
    region  = "us-east-1"
    profile = "907176488429"
  }
  required_version = "= 1.1.9"
  required_providers {
    aws = {
      version = "~> 4"
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "907176488429"
}

# resource "aws_s3_account_public_access_block" "s3_global_deny_public" {
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

locals {
  project           = "aws"
  environment       = "demo"
  standard_tags     = {
    System      = "${local.project}-${local.environment}-${var.territory}"
    Environment = local.environment
    Project     = local.project
    Territory   = var.territory
    Region      = var.region
    Aws_region  = var.aws_region
    Owner       = "mgoldman"
    Automation  = "terraform"
  }
}
