resource "aws_s3_bucket" "deployment_bucket" {
  #bucket = "deployment-${data.aws_caller_identity.acc_info.account_id}-${data.aws_region.cur_region.name}"
  bucket = "deployment-${local.acc_id}-${local.cur_region}"
  tags = {
    Purpose = var.application_name
  }
}


resource "aws_s3_bucket_policy" "allow_access" {
  bucket = aws_s3_bucket.deployment_bucket.id
  policy = data.aws_iam_policy_document.allow_access.json
}

data "aws_iam_policy_document" "allow_access" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.acc_info.account_id]
    }
    actions = [
      "s3:*"
    ]
    resources = [
      aws_s3_bucket.deployment_bucket.arn,
      "${aws_s3_bucket.deployment_bucket.arn}/*",
    ]
  }
}

locals {
  s3_bucket_name = aws_s3_bucket.deployment_bucket.id
  s3_bucket_arn = aws_s3_bucket.deployment_bucket.arn
}

output "s3_bucket_name" {
  description = "Code Pipeline Deployment S3 Bucket Name"
  value = aws_s3_bucket.deployment_bucket.id
}

output "s3_bucket_ARN" {
  description = "Code Pipeline Deployment S3 Bucket ARN"
  value = aws_s3_bucket.deployment_bucket.arn
}

