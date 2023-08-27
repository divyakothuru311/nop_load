terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.13.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}