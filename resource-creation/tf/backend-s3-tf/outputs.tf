output "remote_state_s3_id" {
  description = "The name of the bucket."
  value       = module.state_storage.s3_id
}

output "remote_state_dynamodb_id" {
  description = "The name of the table"
  value       = module.state_storage.dynamodb_id
}


