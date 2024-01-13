
################################################################################
# Set required providers and version
################################################################################

terraform {

  backend "s3" {
    bucket = "ecs-bluegreen-backend20240113173020076200000001" // var.terraform_backend_name - S3 bucket needs to be created before running this
    region = "us-east-2" //var.aws_region
    key    =  "ecr/terraform.tfstate"
    dynamodb_table = "ecs-bluegreen-backend" // var.terraform_backend_name
    encrypt        = true

  }
}



