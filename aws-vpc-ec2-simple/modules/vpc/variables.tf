variable "cidr_range" {
  default = "10.0.0.0/16"
}

variable "tenancy" {
    default = "default"
  
}

variable "vpc_name" {}

variable "environment_tag"{}

variable "module_name"{
	default = "networking"
}

variable "vpn_subnet_cidr_range" {
  default = "10.0.2.0/24"
}

variable "private_subnet_cidr_range" {
      default = "10.0.1.0/24"
}


