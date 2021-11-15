variable "cidr_range" {
  default = "10.0.0.0/16"
}

variable "tenancy" {
    default = "default"
  
}

variable "vpc_name" {}

variable "eks_subnet_cidr_range" {
    default = "10.0.1.0/24"
  
}