variable "vpc_id" {
  description = "VPC id"
}
variable "environment_tag"{}

variable "module_name"{
	default = "database"
}

variable "private_subnets" {
  description = "A map containing private subnets"
}

variable "db_username" {
  description = "Database username"
}

variable "db_password" {
  description = "Database password"
}

variable "db_identifier" {
  description = "Database identifier and SID (size limit may be applied)"
}

variable "db_snapshot" {
  description = "Database snapshot to be replicated"
}