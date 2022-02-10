output "endpoint" {
  value = aws_eks_cluster.terraform_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.terraform_cluster.certificate_authority[0].data
}

output "eks_iam_role_arn" {
  value = aws_iam_role.eks_iam_role.arn
  
}