
provider "aws" {
  region = "us-east-1"  # Change this to your AWS region
}

module "iam_policy" {
  source = "./modules/iam-policy"
}

module "iam_role" {
  source = "./modules/iam-role"  # No need to pass policy_arn anymore
}


module "service_catalog_portfolio" {
  source         = "./modules/service-catalog-portfolio"
}

module "service_catalog_product" {
  source           = "./modules/service-catalog-product"
}
