#Jumphost VM

resource "aws_instance" "jumphost_vm" {
  ami           = "${var.jumphost_vm_ami}"
  instance_type = "${var.jumphost_vm_instance_type}"
  count = 1
  
  subnet_id     = "${var.jumphost_vm_subnet_id}"
  key_name      = "${var.ec2_key_pair}"
  vpc_security_group_ids = [
    aws_security_group.ssh_access.id,
    aws_security_group.public_access.id,
  ]

  user_data = "${file("../modules/ec2/install_apache.sh")}"
  disable_api_termination = false
  monitoring              = false

   depends_on = [
    aws_security_group.public_access
  ]

  
  root_block_device {	
    volume_size = 30
  }  

  tags = {
    Name = "jumphost-vm"
    Environment = "${var.environment_tag}"
    Module      = "compute"	
  }
}


# Private VM

resource "aws_instance" "private_vm" {
  ami           = "${var.private_vm_ami}"
  instance_type = "${var.private_vm_instance_type}"
  
  subnet_id     = "${var.private_vm_subnet_id}"
  key_name      = "${var.ec2_key_pair}"
  
  vpc_security_group_ids = [
    aws_security_group.ssh_access.id,
    aws_security_group.public_access.id,
  ]
  
  
  disable_api_termination = false
  monitoring              = false
  
  root_block_device {
    volume_size = 30
  }  


  tags = {
    Name = "private-vm"
    Environment = "${var.environment_tag}"
    Module      = "compute"		
  }
}



#Security Groups

resource "aws_security_group" "public_access" {
  name        = "allow-internet-outbound-sg"
  description = "Allow access to internet Outbound"

  vpc_id = "${data.aws_vpc.terraform.id}"

 
  egress {
    description = "All ips and protocols"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name        = "allow-internet-outbound-sg"
    Environment = "${var.environment_tag}"
    Module      = "compute"
  }
}


resource "aws_security_group" "ssh_access" {
  name        = "allow-ssh-sg"
  description = "Allow access to ssh from Jumphost and VPC"

  vpc_id = "${data.aws_vpc.terraform.id}"

  ingress {
    description = "SSH from Jumphost and VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_vpc.terraform.cidr_block}","0.0.0.0/0"]
  }

 
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    }
 tags = {
    Name        = "ssh-access-sg"
    Environment = "${var.environment_tag}"
    Module      = "compute"
  }

}

resource "aws_security_group" "ssh-access-default-vpc" {
  # (resource arguments)
}

data "aws_vpc" "terraform" {
		id = var.vpc_id
}

 




