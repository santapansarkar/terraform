output "vpc_id" {
  value = "${aws_vpc.eb-vpc.id}"
  
}

output "controlvm_subnet_id" {
  value = "${aws_subnet.control_vm.id}"
  
}

output "jumphostvm_subnet_id" {
  value = "${aws_subnet.public.id}"
  
}

output "forgerockrmsvm_subnet_id" {
  value = "${aws_subnet.forgerock_rms.id}"
  
}