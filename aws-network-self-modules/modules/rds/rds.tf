data "aws_vpc" "eb_vpc" {
  id = var.vpc_id
}

# database security configuration

resource "aws_security_group" "allow_db_access" {
  name        = "eb-db-access-sg"
  description = "Allow access to database from private VPC network"

  vpc_id = "${data.aws_vpc.eb_vpc.id}"

  ingress {
    description = "All ips and protocols"
    from_port   = 0
    to_port     = 1521
    protocol    = "TCP"
    cidr_blocks = ["${data.aws_vpc.eb_vpc.cidr_block}", "10.10.0.0/16"]
  }

 
  tags = {
    Name        = "eb-db-access-sg"
    Environment = var.environment_tag
    Module      = var.module_name
  }
}

# database instance configuration

resource "aws_db_instance" "eb-db" {
  identifier          = "${var.db_identifier}"
  allocated_storage   = 100
  snapshot_identifier = "${var.db_snapshot}"
  #iops                                 = 3000
  storage_type                          = "gp2" # General purpose SSD
  storage_encrypted                     = true
  engine                                = "oracle-ee"
  engine_version                        = "19.0.0.0.ru-2021-01.rur-2021-01.r2"
  instance_class                        = "db.r5.large"
  name                                  = upper("${var.db_identifier}")
  username                              = "${var.db_username}"
  password                              = "${var.db_password}"
  port                                  = 1521
  publicly_accessible                   = false
  character_set_name                    = "AL32UTF8"
  availability_zone                     = "us-east-1a"
  vpc_security_group_ids                = [aws_security_group.allow_db_access.id]
  #db_subnet_group_name                  = aws_db_subnet_group.db_subnet_group.id
  multi_az                              = false
  backup_retention_period               = 3
  copy_tags_to_snapshot                 = true
  backup_window                         = "04:46-05:16"
  maintenance_window                    = "sun:06:04-sun:06:34"
  final_snapshot_identifier             = "eb-${var.db_identifier}-final"
  enabled_cloudwatch_logs_exports       = ["alert", "audit", "listener", "trace"]
  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  monitoring_interval                   = 60
  monitoring_role_arn                   = aws_iam_role.rds_monitoring.arn
  deletion_protection                   = true
  ca_cert_identifier                    = "rds-ca-2019"
  #parameter_group_name                  = aws_db_parameter_group.oracle_db.name
  #option_group_name                     = aws_db_option_group.oracle_db.name
  apply_immediately                     = true

  lifecycle {
    ignore_changes = [
      engine_version,
      latest_restorable_time
    ]
  }

  tags = {
    Name        = "eb-oracle-db"
    Environment = "${var.environment_tag}"
    Module      = "${var.module_name}"
  }
}