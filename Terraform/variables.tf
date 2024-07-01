variable "REGIONNAME" {
  type = string
}

variable "ENV" {
  type        = string
  description = "The env for which infrastructure is being provisioned (dev, stage, prod)"
}

variable "VPC_CIDR" {
  type = string
}