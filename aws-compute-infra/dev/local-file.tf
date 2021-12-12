resource "local_file" "infra_output" {
    content     = "VPC id is ${module.vpc.vpc_id}"
    filename = "${path.module}/aws-infra.txt"
}