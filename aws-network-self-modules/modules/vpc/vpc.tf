resource "aws_vpc" "eb-vpc" {
  cidr_block       = "${var.cidr_range}"
  instance_tenancy = "${var.tenancy}"

  tags = {
    Name = "${var.vpc_name}"
  }
}

resource "aws_subnet" "eks" {
    vpc_id     = aws_vpc.eb-vpc.id
    cidr_block = "${var.eks_subnet_cidr_range}"

  tags = {
    Name = "eks"
  }

resource "aws_subnet" "dab" {
    vpc_id     = aws_vpc.eb-vpc.id
    cidr_block = "${var.dab_subnet_cidr_range}"

  tags = {
    Name = "dab"
  }  

resource "aws_subnet" "control_vm" {
    vpc_id     = aws_vpc.eb-vpc.id
    cidr_block = "${var.control_vm_subnet_cidr_range}"

  tags = {
    Name = "control_vm"
  }

resource "aws_subnet" "forgerock_rms" {
    vpc_id     = aws_vpc.eb-vpc.id
    cidr_block = "${var.forgerock_rms_subnet_cidr_range}"

  tags = {
    Name = "forgerock_rms"
  }

}