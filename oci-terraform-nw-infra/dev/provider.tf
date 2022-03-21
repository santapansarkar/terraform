terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
      version = "4.68.0"
    }
  }
}

provider "oci" {
  # Configuration options
  auth = "SecurityToken"
  config_file_profile = "DEFAULT"
 
}


