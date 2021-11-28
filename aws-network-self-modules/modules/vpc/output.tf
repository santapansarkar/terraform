output "vpc_id" {
  value = "${aws_vpc.eb-vpc.id}"
  
}

output "subnet_id" {
  value = "${aws_subnet.control_vm.id}"
  
}