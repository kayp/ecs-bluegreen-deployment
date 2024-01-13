data "aws_caller_identity" "acc_info"{}
data "aws_region" "cur_region"{}

locals {
   acc_id = data.aws_caller_identity.acc_info.account_id
   cur_region = data.aws_region.cur_region.name
}

