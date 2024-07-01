resource "aws_vpc" "vpc-playleap" {
  cidr_block = var.VPC_CICR

  enable_dns_hostnames = true

  tags = {
    Name = local.vpcName
    env  = var.ENV
  }
}

output "vpc_id" {
  value = aws_vpc.vpc-playleap.id
}