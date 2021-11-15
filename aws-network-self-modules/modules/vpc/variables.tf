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

variable "dab_subnet_cidr_range" {
    default = "10.0.2.0/24"
  
}

variable "control_vm_subnet_cidr_range" {
    default = "10.0.3.0/24"
  
}

variable "forgerock_rms_subnet_cidr_range" {
    default = "10.0.4.0/24"
  
}

