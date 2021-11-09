variable "DO_TOKEN" {
  type = string
}

variable "DOCKER_USERNAME" {
  type = string
}

variable "DOCKER_PASSWORD" {
  type = string
}

variable "REGION" {
  default = "sgp1"
}

variable "KUBERNETES_VERSION" {
  default = "1.21.5-do.0"
}
