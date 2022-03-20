variable "environment_tags" {
  type = map(string)
}

variable "name" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}

variable "internal" {
  type = bool
}

variable "number_of_instances" {
  type = number
}

variable "instances" {
  type = list(string)
}

variable "acm_certificate_arn" {
  type = string
}