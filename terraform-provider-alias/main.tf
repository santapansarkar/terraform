terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "3.70.0"
      configuration_aliases = [aws.west]
    }

  }
}

provider "aws" {

  profile = "default"
  region  = "us-east-1"
}

provider "aws" {
  profile = "default"
  region  = "us-west-1"
  alias   = "west"
}

resource "aws_instance" "terraform_alias_srv1" {
  ami           = "ami-0ed9277fb7eb570c9"
  instance_type = "t1.micro"

}

resource "aws_instance" "terraform_alias_srv2" {

  ami           = "ami-03af6a70ccd8cb578"
  instance_type = "t2.micro"
  provider      = aws.west
}


