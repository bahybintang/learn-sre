variable "environment_tags" {
  type = map(string)
}

variable "domain_name" {
  type = string
}

variable "zone_id" {
  type = string
}

variable "subject_alternative_names" {
  type = list(string)
  default = []
}