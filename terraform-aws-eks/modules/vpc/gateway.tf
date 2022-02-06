resource "aws_internet_gateway" "terraform_gw" {
  vpc_id = aws_vpc.terraform.id

  tags = {
    Name = "terraform-igw"
  }
}

resource "aws_route_table" "terraform_rt" {
  vpc_id = aws_vpc.terraform.id

  route {
    cidr_block = "${var.private_subnet_cidr_block}"
    gateway_id = aws_internet_gateway.terraform_gw.id
  }

  tags = {
    Name = "terraform-route-table"
  }
}