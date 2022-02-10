variable "cluster_name"{
    default = "terraform-eks"
}

variable "node_instance_type" {
  default = "t2.micro"
}

variable "eks_iam_role_name" {
  
}

variable "eks_iam_role_arn" {

}

variable "eks_vpc_id"{}

variable "eks_subnet_id" {

  type = list(string)
  description = "List of public and private subnets"
}
