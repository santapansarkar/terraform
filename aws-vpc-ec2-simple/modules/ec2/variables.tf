variable "private_vm_ami" {
    default = "ami-0c2b8ca1dad447f8a"
  
}

variable "private_vm_instance_type" {
    default = "t2.micro"
  
}

variable "vpc_id" {
  description = "VPC id"
}

variable "private_vm_subnet_id" {
  
}



variable "ec2_key_pair" {}

variable "environment_tag"{}

variable "module_name"{
	default = "compute"
}

