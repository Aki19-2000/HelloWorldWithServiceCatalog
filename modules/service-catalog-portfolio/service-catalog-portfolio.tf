resource "aws_servicecatalog_portfolio" "s3_bucket_portfolio" {
  name          = "web"
  description   = "Portfolio to manage S3 bucket products"
  provider_name = "akshaya"
}

output "portfolio_id" {
  value = aws_servicecatalog_portfolio.s3_bucket_portfolio.id
}
