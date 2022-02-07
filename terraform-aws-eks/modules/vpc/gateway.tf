resource "aws_internet_gateway" "terraform_gw" {
  vpc_id = aws_vpc.terraform.id

  tags = {
    Name = "terraform-igw"
  }
}

resource "aws_route_table" "terraform_rt" {
  vpc_id = aws_vpc.terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_gw.id
  }

  tags = {
    Name = "terraform-route-table"
  }
}


resource "aws_route_table_association" "terraform_rt_asso" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.terraform_rt.id
}