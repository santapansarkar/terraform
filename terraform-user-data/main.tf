terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.72.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region  = "us-east-1"
  profile = "default"
}


data "template_file" "user_data" {
  template = file("./user_data.yaml")
}

resource "aws_instance" "terraform_user_data" {
  ami             = var.ec2_ami_id
  instance_type   = var.ec2_instance_type
  user_data       = data.template_file.user_data.rendered
  security_groups = ["ssh-access-default-vpc"]
  tags = {
    "Name" = "terraform-user-data"
  }
}