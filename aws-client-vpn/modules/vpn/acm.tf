###########################################
### Self-signed certificate for the VPN ###
###########################################

resource "tls_private_key" "ca_key" {
  algorithm = "RSA"
}

resource "tls_private_key" "client_key" {
  algorithm = "RSA"
}

resource "tls_private_key" "server_key" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "ca_cert" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.ca_key.private_key_pem

  subject {
    common_name  = "AWSPOC Cert Authority"
    organization = "AWS POC"
  }

  is_ca_certificate     = true
  validity_period_hours = 8761

  allowed_uses = [
    "cert_signing",
    "crl_signing",
  ]
}

resource "tls_cert_request" "client_request" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.client_key.private_key_pem

  subject {
    common_name  = "awspoc.vpn.client"
    organization = "AWS POC"
  }
}

resource "tls_cert_request" "server_request" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.server_key.private_key_pem

  subject {
    common_name  = "awspoc.vpn.server"
    organization = "AWS POC"
  }
}

resource "tls_locally_signed_cert" "client_cert" {
  cert_request_pem   = tls_cert_request.client_request.cert_request_pem
  ca_key_algorithm   = "RSA"
  ca_private_key_pem = tls_private_key.ca_key.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca_cert.cert_pem

  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "client_auth",
  ]
}

resource "tls_locally_signed_cert" "server_cert" {
  cert_request_pem   = tls_cert_request.server_request.cert_request_pem
  ca_key_algorithm   = "RSA"
  ca_private_key_pem = tls_private_key.ca_key.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca_cert.cert_pem

  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "aws_acm_certificate" "server_acm" {
  private_key       = tls_private_key.server_key.private_key_pem
  certificate_body  = tls_locally_signed_cert.server_cert.cert_pem
  certificate_chain = tls_self_signed_cert.ca_cert.cert_pem

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "${var.prefix}-vpn-server-acm"
    Environment = var.environment_tag
    Module      = var.module_name
  }

  depends_on = [
    tls_private_key.server_key,
    tls_locally_signed_cert.server_cert,
    tls_self_signed_cert.ca_cert
  ]
}

resource "aws_acm_certificate" "client_acm" {
  private_key       = tls_private_key.client_key.private_key_pem
  certificate_body  = tls_locally_signed_cert.client_cert.cert_pem
  certificate_chain = tls_self_signed_cert.ca_cert.cert_pem

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "${var.prefix}-vpn-client-acm"
    Environment = var.environment_tag
    Module      = var.module_name
  }

  depends_on = [
    tls_private_key.client_key,
    tls_locally_signed_cert.client_cert,
    tls_self_signed_cert.ca_cert
  ]
}

resource "local_file" "vpn-client-private-key" {
  filename = "output/${local.vpn_name}/vpn-client.key"
  sensitive_content  = tls_private_key.client_key.private_key_pem
}

resource "local_file" "vpn-client-certificate" {
  filename = "output/${local.vpn_name}/vpn-client.pem"
  sensitive_content  = tls_locally_signed_cert.client_cert.cert_pem
}
