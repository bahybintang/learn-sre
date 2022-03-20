variable "environment_tags" {
  type = map(string)
}

variable "zone" {
  type = string
}

variable "record_name" {
  type = string
}

variable "record_type" {
  type = string
}

variable "elb_dns_name" {
  type = string
}

variable "elb_zone_id" {
  type = string
}
