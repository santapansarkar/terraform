variable "prefix" {

}

variable "environment_tag" {

}

variable "module_name" {
  default = "vpn"
}

variable "vpc_id" {
  description = "VPC id"
}

variable "private_subnets" {
  description = "A map containing private subnets"
}

variable "client_cidr_block" {
  description = "The CIDR block of the IPs assigned to VPN clients" 
}
