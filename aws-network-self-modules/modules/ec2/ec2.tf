resource "aws_instance" "control_vm" {
  ami           = "${var.control_vm_ami}"
  instance_type = "${var.control_vm_instance_type}"
  
  subnet_id     = "${var.subnet_id}"
  key_name      = "us-east-1-KP"
  vpc_security_group_ids = [aws_security_group.test-sg.id]
  

  tags = {
    Name = "eb-control-vm"
  }
}

resource "aws_security_group" "test-sg" {
  name        = "test-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    description      = "SSH from Anywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "test-sg"
  }
}
