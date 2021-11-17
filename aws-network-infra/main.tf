# Terraform configuration

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.21.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs               = var.vpc_azs
  private_subnets   = var.vpc_eks_subnets
  database_subnets  = var.vpc_db_subnets
  private_subnets   = var.vpc_controlvm_subnets
  private_subnets   = var.vpc_online_subnets
  private_subnets   = var.vpc_oam_subnets
  private_subnets   = var.vpc_trf_subnets
  private_subnets   = var.vpc_forgerock_subnets
  


  tags = var.vpc_tags
}

