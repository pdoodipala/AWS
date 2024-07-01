variable "ENV" {
  type        = string
  description = "The env for which infrastructure is being provisioned (dev, stage, prod)"
  default = "dev"
}