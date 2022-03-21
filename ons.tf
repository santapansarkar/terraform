## This configuration was generated by terraform-provider-oci

resource oci_ons_notification_topic export_oci-devops-notification {
  compartment_id = var.compartment_ocid
  defined_tags = {
    "Oracle-Tags.CreatedBy" = "default/ociuser"
    "Oracle-Tags.CreatedOn" = "2022-03-21T17:30:24.579Z"
  }
  #description = <<Optional value not found in discovery>>
  freeform_tags = {
  }
  name = "oci-devops-notification"
}
