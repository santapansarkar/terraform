#Jumphost VM

resource "aws_instance" "jumphost_vm" {
  ami           = "${var.jumphost_vm_ami}"
  instance_type = "${var.jumphost_vm_instance_type}"
  
  subnet_id     = "${var.jumphost_vm_subnet_id}"
  key_name      = "${var.ec2_key_pair}"
  vpc_security_group_ids = [
    aws_security_group.ssh_access.id,
    aws_security_group.public_access.id,
  ]
  
  #iam_instance_profile = "AmazonSSMRoleForInstancesQuickSetup"
  
  disable_api_termination = false
  monitoring              = false
  
  root_block_device {	
    volume_size = 30
  }  

  tags = {
    Name = "jumphost-vm"
    Environment = "${var.environment_tag}"
    Module      = "${var.module_name}"	
  }
}


#Control VM

resource "aws_instance" "control_vm" {
  ami           = "${var.control_vm_ami}"
  instance_type = "${var.control_vm_instance_type}"
  
  subnet_id     = "${var.control_vm_subnet_id}"
  key_name      = "${var.ec2_key_pair}"
  
  vpc_security_group_ids = [
    aws_security_group.ssh_access.id,
    aws_security_group.public_access.id,
  ]
  
  
  #iam_instance_profile = "AmazonSSMRoleForInstancesQuickSetup"
  
  disable_api_termination = false
  monitoring              = false
  
  root_block_device {
    volume_size = 30
  }  


  tags = {
    Name = "eb-control-vm"
    Environment = "${var.environment_tag}"
    Module      = "${var.module_name}"		
  }
}


#Forgerock-RMS VM

resource "aws_instance" "forgerock_rms_vm" {
  ami           = "${var.forgerock_rms_vm_ami}"
  instance_type = "${var.forgerock_rms_vm_instance_type}"
  
  subnet_id     = "${var.forgerock_rms_vm_subnet_id}"
  key_name      = "${var.ec2_key_pair}"
  
  vpc_security_group_ids = [
    aws_security_group.ssh_access.id,
    aws_security_group.lem_access.id,
	aws_security_group.forgerock_access.id
  ]
  
  #iam_instance_profile = "AmazonSSMRoleForInstancesQuickSetup"
  
  disable_api_termination = false
  monitoring              = false
  
  root_block_device {
    volume_size = 30
  }  

  tags = {
    Name = "eb-forgerock-rms-vm"
    Environment = "${var.environment_tag}"
    Module      = "${var.module_name}"	
  }
}



#Security Groups

resource "aws_security_group" "public_access" {
  name        = "eb-allow-internet-outbound-sg"
  description = "Allow access to internet Outbound"

  vpc_id = "${data.aws_vpc.eb_vpc.id}"

  egress {
    description = "All ips and protocols"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name        = "eb-allow-internet-outbound-sg"
    Environment = "${var.environment_tag}"
    Module      = "${var.module_name}"
  }
}


resource "aws_security_group" "ssh_access" {
  name        = "eb-allow-ssh-sg"
  description = "Allow access to ssh from Jumphost and VPC"

  vpc_id = "${data.aws_vpc.eb_vpc.id}"

  ingress {
    description = "SSH from Jumphost and VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_vpc.eb_vpc.cidr_block}","0.0.0.0/0"]
  }

  tags = {
    Name        = "eb-ssh-access-sg"
    Environment = "${var.environment_tag}"
    Module      = "${var.module_name}"
  }
}


resource "aws_security_group" "forgerock_access" {
  name        = "eb-allow-forgerock-sg"
  vpc_id      = "${data.aws_vpc.eb_vpc.id}"
  description = "Allow forgerock inbound traffic"

  ingress {
    description = "All ips and protocols"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${data.aws_vpc.eb_vpc.cidr_block}"]
  }

  tags = {
    Name        = "eb-forgerock-access-sg"
    Environment = "${var.environment_tag}"
    Module      = "${var.module_name}"
  }
}

resource "aws_security_group" "efs_access" {
  name   = "eb-efs-sg"
  vpc_id = "$data.aws_vpc.eb_vpc.id"

  ingress {
    description = "NFS"
    cidr_blocks = [data.aws_vpc.eb_vpc.cidr_block]
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
  }

  egress {
    description = "default rule"
    cidr_blocks = [data.aws_vpc.eb_vpc.cidr_block]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  tags = {
    Name        = "eb-efs-access-sg"
    Environment = "${var.environment_tag}"
    Module      = "${var.module_name}"
  }
}

resource "aws_security_group" "lem_access" {
  name   = "$eb-lem-sg"
  vpc_id = "${data.aws_vpc.eb_vpc.id}"

  ingress {
    description = "SENTINEL Access TCP"
    cidr_blocks = ["${data.aws_vpc.eb_vpc.cidr_block}"]
    from_port   = 5093
    to_port     = 5093
    protocol    = "tcp"
  }

  ingress {
    description = "SENTINEL Access UDP"
    cidr_blocks = ["${data.aws_vpc.eb_vpc.cidr_block}"]
    from_port   = 5093
    to_port     = 5093
    protocol    = "udp"
  }

  tags = {
    Name        = "eb-lem-access-sg"
    Environment = "${var.environment_tag}"
    Module      = "${var.module_name}"
  }
}

data "aws_vpc" "eb_vpc" {
		id = var.vpc_id
}

 




