variable "regionName" {
  type = string
}

variable "env" {
  type        = string
  description = "The env for which infrastructure is being provisioned (dev, stage, prod)"
}

variable "vpc_cidr" {
  type = string
}