terraform {
  backend "remote" {
      organization = "terraform_cloud_org"
      workspaces {
        name = "terraform_Cloud_Workspace"
      }
    
  }

  required_providers{
       aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "terraform_server" {
  ami           = "ami-0ed9277fb7eb570c9"
  instance_type = "t2.micro"
  tags = {
      Name = "Terraform-Cloud"
  }
}