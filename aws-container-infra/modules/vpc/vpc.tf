resource "aws_vpc" "terraform" {
  cidr_block       = "${var.vpc_cidr_block}"
  instance_tenancy = "default"

  tags = {
    Name = "${var.vpc_name}"
    Environment = "${var.vpc_env}"
    Module = "networking"
  }
}
