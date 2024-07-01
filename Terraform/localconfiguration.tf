locals {
  vpcName = "vpc-devopstooling-${var.ENV}"
}

locals {
  igw-name = "igw-devopstooling-${var.ENV}"
}

locals {
  eip = "eip-devopstooling-${var.ENV}"
}

locals {
  public-routetable = "public-routetable-devopstooling-${var.ENV}"
}

locals {
  private-routetable = "private-routetable-devopstooling-${var.ENV}"
}

locals {
  public-subnet1-name = "public-subnet1-devopstooling-${var.ENV}"
}

locals {
  public-subnet2-name = "public-subnet2-devopstooling-${var.ENV}"
}

locals {
  private-subnet1-name = "private-subnet1-devopstooling-${var.ENV}"
}

locals {
  private-subnet2-name = "private-subnet2-devopstooling-${var.ENV}"
}

locals {
  nat = "nat-devopstooling-${var.ENV}"
}

locals {
  ssh = "ssh-devopstooling-${var.ENV}"
}

