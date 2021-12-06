#Private VM

resource "aws_instance" "private_vm" {
  ami           = "${var.private_vm_ami}"
  instance_type = "${var.private_vm_instance_type}"
  
  subnet_id     = "${var.private_vm_subnet_id}"
  key_name      = "${var.ec2_key_pair}"
  
  vpc_security_group_ids = [
    aws_security_group.ssh_access.id
  ]
  
  
  #iam_instance_profile = "AmazonSSMRoleForInstancesQuickSetup"
  
  disable_api_termination = false
  monitoring              = false



  tags = {
    Name = "private-vm"
    Environment = "${var.environment_tag}"
    Module      = "${var.module_name}"		
  }
}


#Security Groups

resource "aws_security_group" "ssh_access" {
  name        = "private-allow-ssh-sg"
  description = "Allow access to ssh from VPC and VPN"

  vpc_id = "${var.vpc_id}"

  ingress {
    description = "SSH from VPN and VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_vpc.private_vpc.cidr_block}","0.0.0.0/0"]
  }

  tags = {
    Name        = "private-ssh-access-sg"
    Environment = "${var.environment_tag}"
    Module      = "${var.module_name}"
  }
}


resource "aws_security_group" "vpn_access" {
  name        = "vpn-sg"
  description = "Allow access to VPN client"

  vpc_id = "${var.vpc_id}"

  ingress {
    description = "VPN access"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "vpn-access-sg"
    Environment = "${var.environment_tag}"
    Module      = "${var.module_name}"
  }
}


data "aws_vpc" "private_vpc" {
  id = var.vpc_id
}



