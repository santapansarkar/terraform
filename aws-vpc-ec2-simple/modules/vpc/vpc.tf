resource "aws_vpc" "private_vpc" {
  cidr_block       = "${var.cidr_range}"
  instance_tenancy = "${var.tenancy}"

  tags = {
    Name 											  = "${var.vpc_name}"
    Environment                 = "${var.environment_tag}"
    Module                      = "${var.module_name}"	
  }
}

resource "aws_subnet" "private_subnet" {
    vpc_id     = aws_vpc.private_vpc.id
    cidr_block = "${var.private_subnet_cidr_range}"
    availability_zone = "us-east-1a"
  tags = {
    Name                                              = "private-subnet"
    Environment                                       = "${var.environment_tag}"
    Module                                            = "${var.module_name}"
    Tier                                              = "Private"
  }
}

resource "aws_subnet" "vpn_subnet" {
    vpc_id     = aws_vpc.private_vpc.id
    cidr_block = "${var.vpn_subnet_cidr_range}"
    availability_zone = "us-east-1a"
  tags = {
    Name                                              = "vpn-subnet"
    Environment                                       = "${var.environment_tag}"
    Module                                            = "${var.module_name}"
    Tier                                              = "Private"
  }
}

