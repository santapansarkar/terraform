variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "vpc_name" {

    default = "terraform-vpc"
  
}

variable "vpc_env" {
  default = "development"
}

variable "public_subnet_cidr_block" {
  
  default = "10.0.1.0/24"

}


variable "private_subnet_cidr_block" {
  
  default = "10.0.2.0/24"

}

variable "public_subnet_name" {
  default = "terraform-public-subnet"
}

variable "private_subnet_name" {
  default = "terraform-private-subnet"
}