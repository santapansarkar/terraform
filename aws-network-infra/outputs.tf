# Output variable definitions

output "vpc_private_subnets" {
  description = "IDs of the VPC's private subnets"
  value       = module.vpc.private_subnets
}

