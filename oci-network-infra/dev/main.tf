module "vcn" {
  source = "../modules/vcn"
  compartment_id = "ocid1.compartment.oc1..aaaaaaaaslunp43xlbu3n574g2ai4xf6vge3cjmerdpnthhgljnlgwhdncbq"
  vcn_cidr_blocks = ["10.0.0.0/29"]
  vcn_display_name = "terraform-vcn"
  vcn_dns_label = "terraform-dns"
  subnet_cidr_block = "10.0.0.0/30"
}