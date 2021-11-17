# Input variable definitions

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "eb-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}


variable "vpc_eks_subnets" {
  description = "Private subnets for VPC - purpose EKS"
  type        = list(string)
  default     = ["10.0.155.0/24", "10.0.156.0/24"]
}


variable "vpc_db_subnets" {
  description = "Private subnets for VPC - purpose EKS"
  type        = list(string)
  default     = ["10.0.154.0/24"]
}

variable "vpc_controlvm_subnets" {
  description = "Private subnets for VPC - purpose EKS"
  type        = list(string)
  default     = ["10.0.150.0/24"]
}

variable "vpc_online_subnets" {
  description = "Private subnets for VPC - purpose EKS"
  type        = list(string)
  default     = ["10.0.151.0/24"]
}

variable "vpc_oam_subnets" {
  description = "Private subnets for VPC - purpose EKS"
  type        = list(string)
  default     = ["10.0.153.0/24"]
}

variable "vpc_trf_subnets" {
  description = "Private subnets for VPC - purpose EKS"
  type        = list(string)
  default     = ["10.0.152.0/24"]
}

variable "vpc_forgerock_subnets" {
  description = "Private subnets for VPC - purpose EKS"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "vpc_tags" {
  description = "Tags to apply to resources created by VPC module"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "dev"
  }
}
