resource "aws_efs_file_system" "eb_efs" {
  creation_token = "eb-efs"
  availability_zone_name = "us-east-1a"  
  encrypted = true
  kms_key_id = "${var.default_kms_encryption_key}"
  

  tags = {
    Name        = "eb-shared-storage"
    Environment = "${var.environment_tag}"
    Module      = "${var.module_name}"
  }
}

resource "aws_efs_mount_target" "eb_efs_mount_eks_a" {
  file_system_id  = aws_efs_file_system.eb_efs.id
  subnet_id       = "${var.eks_a_subnet}"
  security_groups = ["${var.efs_sg}"]
}

resource "aws_efs_mount_target" "eb_efs_mount_eks_b" {
  file_system_id  = aws_efs_file_system.eb_efs.id
  subnet_id       = "${var.eks_b_subnet}"
  security_groups = ["${var.efs_sg}"]
}