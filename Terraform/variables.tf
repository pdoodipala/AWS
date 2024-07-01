variable "ENV" {
  type        = string
  description = "The env for which infrastructure is being provisioned (dev, stage, prod)"
}

variable "VPC_CICR" {
  type        = string
  description = "The CIDR address for VPC in env"
}

variable "public_subnet_1" {
  type        = string
  description = "The CIDR address for public_subnet_1 in vpc"
}

variable "public_subnet_2" {
  type        = string
  description = "The CIDR address for public_subnet_2 in vpc"
}

variable "private_subnet_1" {
  type        = string
  description = "The CIDR address for private_subnet_1 in vpc"
}

variable "private_subnet_2" {
  type        = string
  description = "The CIDR address for private_subnet_2 in vpc"
}

variable "availability-zones" {
  type = list(string)
  default = [ "us-east-1a", "us-east-1b" ]
}

variable "key_pair_name" {
  type        = string
  description = "The key pair name for connecting to ec2"
}

variable "instance_ami" {
  type        = string
  description = "ami for ec2 instance"
}

variable "instanceType" {
  type        = string
  description = "Type of instance"
}

variable "root_device_size" {
  type        = string
  description = "root volume size for ec2 instance"
}

variable "root_device_type" {
  type        = string
  description = "root volume device type for ec2 instance"
}