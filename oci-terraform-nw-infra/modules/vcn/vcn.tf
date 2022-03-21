resource "oci_core_vcn" "terraform_vcn" {
    #Required
    compartment_id = var.compartment_id
    #Optional
    cidr_blocks = var.vcn_cidr_blocks
    #defined_tags = {"Operations.CostCenter"= "terraform"}
    display_name = var.vcn_display_name
    #dns_label = var.vcn_dns_label
    #freeform_tags = {"Department"= "terraform"}
}