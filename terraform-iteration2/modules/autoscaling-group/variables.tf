variable "image_id" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "key_name" {
  type = string
}
variable "nginx_image_id" {
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
variable "bastion-sg" {}

variable "bastion_subnet" {}

variable "bastion_subnet2" {}

variable "nginx-sg" {}

variable "nginx_subnet" {}

variable "nginx_subnet2" {}

variable "tooling-sg" {}

variable "tooling_subnet" {}

variable "tooling_subnet2" {}

variable "wordpress-sg" {}

variable "wordpress_subnet" {}

variable "wordpress_subnet2" {}

variable "aws_availability_zones" {}