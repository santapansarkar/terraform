
resource "aws_security_group" "vpn_access" {
  name   = "${var.prefix}-shared-vpn-access"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }


  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "${var.prefix}-shared-vpn-access"
    Environment = var.environment_tag
    Module      = var.module_name
  }
}
