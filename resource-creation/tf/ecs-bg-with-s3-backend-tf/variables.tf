variable "application_name" {
  description = "Name of the application"
  type        = string
}


variable "aws_profile" {
    type = string
    default = null
}

variable "aws_region" {
    type = string
    default = null
}

variable "ecr_repo"{
  description = "Name of ECR Repo"
  type = string
  default = null
}
variable "vpc_id"{
  description = "VPC ID"
  type = string
  default = null
}

variable "subnet_ids"{
  description = "VPC ID"
  type = list
  default = null
}
variable "container_image_blue"{
  description = "Container Image for Blue ECS Deployment"
  type = string
  default = null
}

variable "image_uri"{
  description = "Image URI for ECS Task"
  type = string
  default = null
}
variable "terraform_backend_name"{
  description = "Name for backend resources"
  type = string
  default = null
}
variable "create_backend"{
  description = "Create Terraform backend state"
  type = number
  default = 0
 
  validation {
   condition =  contains ([0 , 1], var.create_backend)  
   error_message = "Only 0 and 1 are acceptable values."
  }

}
 ## IAM role names -- optional

variable "ecs_task_execution_role"{
  description = "ECS Task Execution Role"
  type = string
  default = "ecs_task_execution_role"
}

variable "codedeploy_ecs_role"{
  description = "Code Deploy Role For ECS Cluster"
  type = string
  default = "code_deploy_ecs_role"
}

variable "codepipeline_full_access"{
  description = "Code Pipeline execution role"
  type = string
  default = "codepipeline_full_access"
}

