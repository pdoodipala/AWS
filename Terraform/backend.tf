#terraform {
#  backend "s3" {
#    bucket         = "terraform-s3-tf" # change this
#    key            = "terraform/terraform.tfstate"
#    region         = "us-east-1"
#    encrypt        = true
#    dynamodb_table = "terraform-lock"
#  }
#}