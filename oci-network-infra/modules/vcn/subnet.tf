resource "oci_core_subnet" "test_subnet" {
    #Required
    cidr_block = var.subnet_cidr_block
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.terraform_vcn.id

    #Optional
    #availability_domain = var.subnet_availability_domain
    #defined_tags = {"Operations.CostCenter"= "42"}
    #dhcp_options_id = oci_core_dhcp_options.test_dhcp_options.id
    display_name = var.subnet_display_name
    #dns_label = var.subnet_dns_label
    #freeform_tags = {"Department"= "Finance"}
    #route_table_id = oci_core_vcn.terraform_vcn.default_route_table.id
    #security_list_ids = oci_core_vcn.terraform_vcn.default_security_list_id
}