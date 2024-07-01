# vpc
resource "aws_vpc" "vpc-devopstooling" {
  cidr_block = var.VPC_CICR

  enable_dns_hostnames = true

  tags = {
    Name = local.vpcName
    env  = var.ENV
  }
}

output "vpc_id" {
  value = aws_vpc.vpc-devopstooling.id
}

# internetgateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-devopstooling.id

  tags = {
    Name = local.igw-name
  }
}

#  eip

resource "aws_eip" "eip" {
  vpc = true

  tags = {
    Name = local.eip
  }
}

# public subnet-1
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.vpc-devopstooling.id
  cidr_block              = var.public_subnet_1
  availability_zone       = var.availability-zones[0]
  map_public_ip_on_launch = true

  tags = {
    "Name" = local.public-subnet1-name
  }
}

# public subnet-2
resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.vpc-devopstooling.id
  cidr_block              = var.public_subnet_2
  availability_zone       = var.availability-zones[1]
  map_public_ip_on_launch = true

  tags = {
    "Name" = local.public-subnet2-name
  }
}

# private subnet-1
resource "aws_subnet" "private-subnet-1"  {
  vpc_id            = aws_vpc.vpc-devopstooling.id
  cidr_block        = var.private_subnet_1
  availability_zone = var.availability-zones[0]

  tags = {
    "Name" = local.private-subnet1-name

  }
}

# private subnet-2
resource "aws_subnet" "private-subnet-2" {
  vpc_id            = aws_vpc.vpc-devopstooling.id
  cidr_block        = var.private_subnet_2
  availability_zone = var.availability-zones[1]

  tags = {
    "Name"  = local.private-subnet2-name
  }
}

output "private_subnet_id_1" {
  value = aws_subnet.private-subnet-1.id
}

output "private_subnet_id_2" {
  value = aws_subnet.private-subnet-2.id
}

# nat gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public-subnet-1.id

  tags = {
    Name = local.nat
  }

  depends_on = [aws_internet_gateway.igw]
}

# public routetable
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc-devopstooling.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = local.public-routetable
  }
}

# private routetable
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc-devopstooling.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = local.private-routetable
  }
}

# public routetable association with public subnet1
resource "aws_route_table_association" "public-sub1-association" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public.id
}
# public routetable association with public subnet2
resource "aws_route_table_association" "public-sub2-association" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public.id
}

# private routetable association with private subnet1
resource "aws_route_table_association" "private-sub1-association" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private.id
}

# private routetable association with private subnet1
resource "aws_route_table_association" "private-sub2-association" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private.id
}