resource "local_file" "infra_output" {
  content  = "VPC id is ${module.vpc.vpc_id} \n"
  filename = "${path.module}/aws-infra.txt"
}