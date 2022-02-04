variable "cluter_name"{
    default = "terraform-eks"
}

variable "cluster_iam_role" {
  
}

variable "node_instance_type" {
  default = "t2.micro"
}