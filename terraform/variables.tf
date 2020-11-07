variable "region" {
  type    = string
}

variable "project_name" {
  type = string
}

variable "lambda_packages_path" {
  type    = string
  default = "../lambda/packages"
}