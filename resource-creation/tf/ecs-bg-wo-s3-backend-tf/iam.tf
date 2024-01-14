resource "aws_iam_role" "ecs_task_execution_role" {
  name = var.ecs_task_execution_role
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "ECSTaskRole"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })

}


resource "aws_iam_role" "codedeploy_ecs_role" {
  name = var.codedeploy_ecs_role
  managed_policy_arns = ["arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"]
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "CodeDeployECSRole"
        Principal = {
          Service = "codedeploy.amazonaws.com"
        }
      },
    ]
  })

}


resource "aws_iam_role" "codepipeline_full_access" {
  name = var.codepipeline_full_access
  managed_policy_arns = ["arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess",
                         "arn:aws:iam::aws:policy/AdministratorAccess"]
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "CodeDeployECSRole"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
      },
    ]
  })

}



locals {
  ecs_task_execution_role = aws_iam_role.ecs_task_execution_role.arn
  codedeploy_ecs_role = aws_iam_role.codedeploy_ecs_role.arn
  codepipeline_full_access_role = aws_iam_role.codepipeline_full_access.arn
}

output ecs_task_execution_role {
  value = local.ecs_task_execution_role
  description = "ECS Task Execution Role"
}

output code_deploy_ecs_role {
  value = local.codedeploy_ecs_role
  description = "Code Deploy ECS Role ARN"
}

