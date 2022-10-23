variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "vpc_cidr" {
  type = string
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
variable "image_id" {
  type = string
}
variable "max_size" {
  type = number
}
variable "min_size" {
  type = number
}
variable "desired_capacity" {
  type = number
}
variable "instance_type" {
  type = string
}
variable "key_name" {
  type = string
}
variable "db_name" {}

variable "username" {}

variable "password" {}

variable "multi_az" {}

variable "nginx_image_id" {}
