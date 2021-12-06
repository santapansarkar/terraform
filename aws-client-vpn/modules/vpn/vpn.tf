##########################
####### VPN client #######
##########################

resource "aws_ec2_client_vpn_endpoint" "client_vpn" {
  description            = "Client VPN"
  server_certificate_arn = aws_acm_certificate.server_acm.arn
  client_cidr_block      = var.client_cidr_block
  split_tunnel           = true

  #TODO: saml_provider_arn ??

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.client_acm.arn
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.vpn_log_group.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.vpn_log_stream.name
  }

  tags = {
    Name        = local.vpn_name
    Environment = var.environment_tag
    Module      = var.module_name
  }
}

###############################
####### VPN Cloudwatch ########
###############################

resource "aws_cloudwatch_log_group" "vpn_log_group" {
  name = "${var.prefix}-vpn-log-group"
}

resource "aws_cloudwatch_log_stream" "vpn_log_stream" {
  name = "${var.prefix}-vpn-log-stream"

  log_group_name = aws_cloudwatch_log_group.vpn_log_group.name
}


################################
####### VPN Associations #######
################################

# Remove to save resources

resource "aws_ec2_client_vpn_network_association" "private_vpn_subnet_association" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client_vpn.id
  subnet_id              = var.private_subnets.private_vpn.id
}


######################################
####### Setting up permissions #######
######################################

resource "null_resource" "client_vpn_ingress" {
  depends_on = [aws_ec2_client_vpn_endpoint.client_vpn]
  provisioner "local-exec" {
    when    = create
    command = "aws ec2 authorize-client-vpn-ingress --client-vpn-endpoint-id ${aws_ec2_client_vpn_endpoint.client_vpn.id} --target-network-cidr 0.0.0.0/0 --authorize-all-groups"
  }
  lifecycle {
    create_before_destroy = true
  }

  triggers = {
    aws_ec2_client_vpn_endpoint : aws_ec2_client_vpn_endpoint.client_vpn.id,
  }
}

resource "null_resource" "client_vpn_security_group" {
  depends_on = [aws_ec2_client_vpn_endpoint.client_vpn, aws_security_group.vpn_access]
  provisioner "local-exec" {
    when    = create
    command = "aws ec2 apply-security-groups-to-client-vpn-target-network --client-vpn-endpoint-id ${aws_ec2_client_vpn_endpoint.client_vpn.id} --vpc-id ${aws_security_group.vpn_access.vpc_id} --security-group-ids ${aws_security_group.vpn_access.id}"
  }

  triggers = {
    aws_ec2_client_vpn_endpoint : aws_ec2_client_vpn_endpoint.client_vpn.id,
    aws_security_group : aws_security_group.vpn_access.id
  }

  lifecycle {
    create_before_destroy = true
  }
}

###############################
##### OpenVPN config file #####
###############################


resource "local_file" "vpn-client-ovpn" {
  filename = "output/${local.vpn_name}/${var.prefix}-vpn.ovpn"
  sensitive_content  = <<-EOT
    client
    dev tun
    proto udp
    remote ${aws_ec2_client_vpn_endpoint.client_vpn.id}.prod.clientvpn.${data.aws_region.current.id}.amazonaws.com 443
    remote-random-hostname
    resolv-retry infinite
    nobind
    remote-cert-tls server
    cipher AES-256-GCM
    verb 3
    
    <ca>
    ${tls_self_signed_cert.ca_cert.cert_pem}
    </ca>
    
    reneg-sec 0
    
    cert ./${basename(local_file.vpn-client-certificate.filename)}
    key ./${basename(local_file.vpn-client-private-key.filename)}

  EOT
}

# More information in https://craig-godden-payne.medium.com/setup-managed-client-vpn-in-aws-using-terraform-342584d4f1e3
