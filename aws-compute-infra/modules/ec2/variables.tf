variable "private_vm_ami" {
    default = "ami-0c2b8ca1dad447f8a"
  
}

variable "private_vm_instance_type" {
    default = "t2.micro"
    validation {
      condition = can(regex("^t2.micro", var.private_vm_instance_type))
      error_message = ("The instance type value must be the right.")
    }
  
}

variable "vpc_id" {
  description = "VPC id"
}

variable "jumphost_vm_ami" {
    default = "ami-0c2b8ca1dad447f8a"
  
}

variable "jumphost_vm_instance_type" {
    default = "t2.micro"
  
}

variable "ec2_key_pair" {}

variable "environment_tag"{}

variable "jumphost_vm_subnet_id"{}

variable "private_vm_subnet_id"{}

