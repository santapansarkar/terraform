output "vpc_id" {
  value = aws_vpc.terraform.id
}

output "jumphost_vm_subnet_id" {
  value = aws_subnet.public.id
}

output "private_vm_subnet_id" {
  value = aws_subnet.private.id
}

