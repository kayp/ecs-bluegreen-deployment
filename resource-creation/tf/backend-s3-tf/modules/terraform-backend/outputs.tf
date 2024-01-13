################################################################################
# s3 bucket outputs
################################################################################

output "s3_id" {
  description = "The name of the bucket."
  value       = aws_s3_bucket.this.id
}

output "s3_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = aws_s3_bucket.this.arn
}

################################################################################
# DynamoDB outputs
################################################################################

output "dynamodb_arn" {
  description = "The arn of the table"
  value       = aws_dynamodb_table.this.arn
}

output "dynamodb_id" {
  description = "The name of the table"
  value       = aws_dynamodb_table.this.id
}


