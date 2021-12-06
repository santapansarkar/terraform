output "vpc_id" {
  value = "${aws_vpc.private_vpc.id}"
  
}

output "self_vpn_private_id" {
  value = "${aws_subnet.private_subnet.id}"
  
}

