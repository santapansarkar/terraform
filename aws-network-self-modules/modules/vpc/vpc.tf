resource "aws_vpc" "eb-vpc" {
  cidr_block       = "${var.cidr_range}"
  instance_tenancy = "${var.tenancy}"

  tags = {
    Name = "${var.vpc_name}"
  }
}

resource "aws_subnet" "eks_a" {
    vpc_id     = aws_vpc.eb-vpc.id
    cidr_block = "${var.eks_a_subnet_cidr_range}"
    availability_zone = "us-east-1a"
  tags = {
    Name = "eb-subnet-private-eks-a"
  }
}

resource "aws_subnet" "eks_b" {
    vpc_id     = aws_vpc.eb-vpc.id
    cidr_block = "${var.eks_b_subnet_cidr_range}"
    availability_zone = "us-east-1b"
  tags = {
    Name = "eb-subnet-private-eks-b"
  }
}

resource "aws_subnet" "dab" {
    vpc_id     = aws_vpc.eb-vpc.id
    cidr_block = "${var.dab_subnet_cidr_range}"
    availability_zone = "us-east-1a"
  tags = {
    Name = "eb-subnet-private-dab-a"
  }  
}

resource "aws_subnet" "control_vm" {
    vpc_id     = aws_vpc.eb-vpc.id
    cidr_block = "${var.control_vm_subnet_cidr_range}"
    availability_zone = "us-east-1a"    
  tags = {
    Name = "eb-subnet-private-controlvm-a"
  }
}


resource "aws_subnet" "online" {
    vpc_id     = aws_vpc.eb-vpc.id
    cidr_block = "${var.online_subnet_cidr_range}"
    availability_zone = "us-east-1a"    
  tags = {
    Name = "eb-subnet-private-online-a"
  }
}
resource "aws_subnet" "forgerock_rms" {
    vpc_id     = aws_vpc.eb-vpc.id
    cidr_block = "${var.forgerock_rms_subnet_cidr_range}"
    availability_zone = "us-east-1a"
  tags = {
    Name = "eb-subnet-private-forgerock-rms"
  }

}

resource "aws_subnet" "oam" {
    vpc_id     = aws_vpc.eb-vpc.id
    cidr_block = "${var.oam_subnet_cidr_range}"
    availability_zone = "us-east-1a"
  tags = {
    Name = "eb-subnet-private-oam-a"
  }

}


resource "aws_subnet" "trf" {
    vpc_id     = aws_vpc.eb-vpc.id
    cidr_block = "${var.trf_subnet_cidr_range}"
    availability_zone = "us-east-1a"
  tags = {
    Name = "eb-subnet-private-trf-a"
  }

}



resource "aws_subnet" "vpn" {
    vpc_id     = aws_vpc.eb-vpc.id
    cidr_block = "${var.vpn_subnet_cidr_range}"
    availability_zone = "us-east-1b"
  tags = {
    Name = "eb-subnet-private-vpn"
  }

}

resource "aws_subnet" "public" {
    vpc_id     = aws_vpc.eb-vpc.id
    cidr_block = "${var.public_subnet_cidr_range}"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = "true"

  tags = {
    Name = "eb-subnet-public"
  }

}


resource "aws_internet_gateway" "eb-igw" {
  vpc_id = aws_vpc.eb-vpc.id

  tags = {
    Name = "eb-igw"
  }
}

resource "aws_eip" "nat-gateway-elastic-ip" {
  vpc              = true

  tags = {
    Name = "eb-eip"
  }


}

resource "aws_nat_gateway" "eb-nat-gateway" {
  allocation_id = aws_eip.nat-gateway-elastic-ip.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "eb-nat-gateway"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.eb-igw]
}

resource "aws_route_table" "eb-nat-route-table" {
  vpc_id = aws_vpc.eb-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    #nat_gateway_id = aws_internet_gateway.eb-igw.id
    nat_gateway_id = aws_nat_gateway.eb-nat-gateway.id
  }

  tags = {
    Name = "eb-nat-route-table"
  }
}

resource "aws_route_table_association" "nat-route" {
  subnet_id = aws_subnet.control_vm.id
  route_table_id = aws_route_table.eb-nat-route-table.id
}


resource "aws_route_table" "eb-public-route-table" {
  vpc_id = aws_vpc.eb-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eb-igw.id
    
  }

  tags = {
    Name = "eb-public-route-table"
  }
}

resource "aws_route_table_association" "public-route" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.eb-public-route-table.id
}


output "vpc_id" {
  value = "${aws_vpc.eb-vpc.id}"
  
}

output "subnet_id" {
  value = "${aws_subnet.control_vm.id}"
  
}