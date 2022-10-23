variable "vpc_cidr" {
  type = string
}
variable "enable_dns_support" {
  type = bool
}
variable "enable_dns_hostnames" {
  type = bool
}
variable "name" {
  type = string
}
variable "public_subnet" {
  type = list(any)
}
variable "nginx_private_subnet" {
  type = list(any)
}
variable "compute_private_subnet" {
  type = list(any)
}
variable "data_private_subnet" {
  type = list(any)
}
