
provider "aws" {
  region = "us-east-1"  # Change this to your AWS region
}


module "service_catalog_portfolio" {
  source         = "./modules/service-catalog-portfolio"
}

module "service_catalog_product" {
  source           = "./modules/service-catalog-product"
}
