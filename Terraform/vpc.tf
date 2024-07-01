resource "aws_vpc" "vpc-devopstooling" {
  cidr_block = var.VPC_CIDR

  enable_dns_hostnames = true

  tags = {
    Name = local.vpcName
    env  = var.ENV
  }
}

output "vpc_id" {
  value = aws_vpc.vpc-devopstooling.id
}