variable "cidr_range" {
  default = "10.0.0.0/16"
}

variable "tenancy" {
    default = "default"
  
}

variable "vpc_name" {}

variable "eks_a_subnet_cidr_range" {
      default = "10.0.155.0/24"
  
}

variable "eks_b_subnet_cidr_range" {
      default = "10.0.156.0/24"
  
}

variable "dab_subnet_cidr_range" {
    default = "10.0.154.0/24"
  
}

variable "control_vm_subnet_cidr_range" {
    default = "10.0.150.0/24"
  
}

variable "forgerock_rms_subnet_cidr_range" {
    default = "10.0.0.0/24"
  
}

variable "online_subnet_cidr_range" {
    default = "10.0.151.0/24"
  
}

variable "oam_subnet_cidr_range" {
    default = "10.0.153.0/24"
  
}

variable "trf_subnet_cidr_range" {
    default = "10.0.152.0/24"
  
}

variable "vpn_subnet_cidr_range" {
    default = "10.0.1.0/24"
  
}

variable "nat_subnet_cidr_range" {
    default = "10.0.100.0/24"
  
}