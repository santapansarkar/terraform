variable "compartment_id" {
  
}

variable "vcn_cidr_blocks" {
  default = ["10.0.0.0/29"]
  
}

variable "vcn_display_name" {
  default = "terraform_vcn" 
  
}

variable "vcn_dns_label" {
  default = "terraform-dns"
  
}

#subnet related variables

variable "subnet_cidr_block"{
  default = "10.0.0.0/30"
}

variable "subnet_display_name" {
  default = "terraform-subnet"
}


