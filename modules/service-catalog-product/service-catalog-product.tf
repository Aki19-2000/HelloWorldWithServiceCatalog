resource "aws_servicecatalog_product" "example" {
  name          = "webapplication"
  owner         = "akshaya"
  description   = "A simple web application product"
  distributor   = "example-distributor"
  support_email = "support@example.com"
  support_url   = "https://example.com/support"
  type          = "EXTERNAL"

  provisioning_artifact_parameters {
    name                         = "v1"
    description                  = "Version 1"
    type                         = "EXTERNAL"  # Ensure this is set to EXTERNAL
    template_url                 = "https://akired18.s3.us-east-1.amazonaws.com/webapp1.tar.gz"
    disable_template_validation  = true
  }
}
