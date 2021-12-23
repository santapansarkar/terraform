terraform {
required_providers {
  aws = {
      source  = "hashicorp/aws"
      version = "2.69.0"
  }
}

}

provider "aws" {
    region = "us-east-1"
    profile = "default"
  
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "ec2_example" {
  instance_type = "t2.micro"
  ami = data.aws_ami.amazon_linux.id
  depends_on = [
    aws_s3_bucket.s3_example
  ]

}

resource "aws_s3_bucket" "s3_example" {
  bucket = "example-s3-bucket-112567"
  acl    = "private"

  tags = {
    Name        = "example-s3-bucket-112567"
    Environment = "Dev"
  
}
}

resource "aws_eip" "eip_example" {
  instance = aws_instance.ec2_example.id
  vpc      = true
}

module "example_sqs_queue" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "2.1.0"

  depends_on = [aws_s3_bucket.s3_example, aws_instance.ec2_example]
}
