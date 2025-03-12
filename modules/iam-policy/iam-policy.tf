resource "aws_iam_policy" "s3_resource_creation_and_artifact_access_policy" {
  name        = "S3ResourceCreationAndArtifactAccessPolicy2"
  description = "Policy to allow access to create and manage S3 buckets and artifacts"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : "s3:GetObject",
        "Resource" : "*",
        "Condition" : {
          "StringEquals" : {
            "s3:ExistingObjectTag/servicecatalog:provisioning" : "true"
          }
        }
      },
      {
        "Action" : [
          "s3:CreateBucket*",
          "s3:DeleteBucket*",
          "s3:Get*",
          "s3:List*",
          "s3:PutBucketTagging"
        ],
        "Resource" : "arn:aws:s3:::*",
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "resource-groups:CreateGroup",
          "resource-groups:ListGroupResources",
          "resource-groups:DeleteGroup",
          "resource-groups:Tag"
        ],
        "Resource" : "*",
        "Effect" : "Allow"
      },
      {
        "Action" : [
          "tag:GetResources",
          "tag:GetTagKeys",
          "tag:GetTagValues",
          "tag:TagResources",
          "tag:UntagResources"
        ],
        "Resource" : "*",
        "Effect" : "Allow"
      }
    ]
  })
}

output "policy_arn" {
  value = aws_iam_policy.s3_resource_creation_and_artifact_access_policy.arn
}
