terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"

}