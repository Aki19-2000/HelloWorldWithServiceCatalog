resource "aws_iam_role" "service_catalog_role" {
  name               = "service-catalog-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "GivePermissionsToServiceCatalog"
        Effect    = "Allow"
        Principal = {
          Service = "servicecatalog.amazonaws.com"
        }
        Action   = "sts:AssumeRole"
      },
      {
        Effect    = "Allow"
        Principal = {
          AWS = "arn:aws:iam::510278866235:root"
        }
        Action   = "sts:AssumeRole"
        Condition = {
          StringLike = {
            "aws:PrincipalArn" = [
              "arn:aws:iam::510278866235:role/TerraformEngine/TerraformExecutionRole*",
              "arn:aws:iam::510278866235:role/TerraformEngine/ServiceCatalogExternalParameterParserRole*",
              "arn:aws:iam::510278866235:role/TerraformEngine/ServiceCatalogTerraformOSParameterParserRole*"
            ]
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "ec2_full_access" {
  name        = "AmazonEC2FullAccess"
  description = "Full access to EC2 and related services"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "ec2:*"
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "elasticloadbalancing:*"
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "cloudwatch:*"
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "autoscaling:*"
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "iam:CreateServiceLinkedRole"
        Resource = "*"
        Condition = {
          StringEquals = {
            "iam:AWSServiceName" = [
              "autoscaling.amazonaws.com",
              "ec2scheduled.amazonaws.com",
              "elasticloadbalancing.amazonaws.com",
              "spot.amazonaws.com",
              "spotfleet.amazonaws.com",
              "transitgateway.amazonaws.com"
            ]
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "attach_ec2_full_access" {
  name       = "attach-ec2-full-access-policy"
  policy_arn = aws_iam_policy.ec2_full_access.arn
  roles      = [aws_iam_role.service_catalog_role.name]
}

resource "aws_iam_policy" "additional_policy" {
  name        = "AdditionalPolicy"
  description = "Additional policy for EC2 and related services"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "ec2:*"
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "elasticloadbalancing:*"
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "cloudwatch:*"
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "autoscaling:*"
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "iam:CreateServiceLinkedRole"
        Resource = "*"
        Condition = {
          StringEquals = {
            "iam:AWSServiceName" = [
              "autoscaling.amazonaws.com",
              "ec2scheduled.amazonaws.com",
              "elasticloadbalancing.amazonaws.com",
              "spot.amazonaws.com",
              "spotfleet.amazonaws.com",
              "transitgateway.amazonaws.com"
            ]
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "attach_additional_policy" {
  name       = "attach-additional-policy"
  policy_arn = aws_iam_policy.additional_policy.arn
  roles      = [aws_iam_role.service_catalog_role.name]
}
