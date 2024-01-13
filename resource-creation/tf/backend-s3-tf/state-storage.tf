
module "state_storage" {
  source = "./modules/terraform-backend"

  tf_state_storage_bucket_name        = var.terraform_backend_name
  tf_state_storage_dynamodb_lock_name = var.terraform_backend_name
  aws_account_id                      = local.acc_id
}

