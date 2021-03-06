resource "aws_eks_cluster" "terraform_cluster"{

    name = var.cluster_name
    role_arn = var.eks_iam_role_arn
    version                 = "1.21"
  #  cluster_endpoint_private_access = true
  #  cluster_endpoint_public_access  = true

/*
  cluster_encryption_config = [{
    provider_key_arn = "ac01234b-00d9-40f6-ac95-e42345f78b00"
    resources        = ["secrets"]
  }]
*/
 
  vpc_config {
    subnet_ids = var.eks_subnet_id
    endpoint_private_access = true
    endpoint_public_access  = true
  }


  tags = {
    Environment = "dev"
    Terraform   = "true"
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks_iam_policy
  ]



}



