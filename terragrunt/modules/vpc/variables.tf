variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}

variable "vpc_name" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "environment_tags" {
  type = map(string)
}