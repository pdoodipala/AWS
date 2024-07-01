resource "aws_vpc" "vpc-devopstooling" {
  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true

  tags = {
    Name = local.vpcName
    env  = var.env
  }
}

output "vpc_id" {
  value = aws_vpc.vpc-devopstooling.id
}