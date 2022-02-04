resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.terraform.id
  cidr_block = "${var.public_subnet_cidr_block}"
  map_public_ip_on_launch = "true"
  availability_zone_id = "use1-az1"
  tags = {
    Name = "${var.public_subnet_name}"
    Environment = "${var.vpc_env}"
    Module = "networking"
  }
}


resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.terraform.id
  cidr_block = "${var.private_subnet_cidr_block}"
  availability_zone_id = "use1-az2"
  tags = {
    Name = "${var.private_subnet_name}"
    Environment = "${var.vpc_env}"
    Module = "networking"
  }
}


