terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.66.0"
    }
  }
}


provider "aws" {
  region  = "us-east-1"
}