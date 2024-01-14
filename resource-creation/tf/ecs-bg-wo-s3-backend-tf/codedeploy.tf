resource "aws_codedeploy_app" "codedeploy_app" {
  compute_platform = "ECS"
  name             = var.application_name
}


resource "aws_codedeploy_deployment_group" "blue_green_grp" {
  app_name               = aws_codedeploy_app.codedeploy_app.name
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  deployment_group_name  = var.application_name
  service_role_arn       = local.codedeploy_ecs_role

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = local.ecs_cluster_name
    service_name = local.ecs_service_name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [local.alb_listener_arn_blue]
      }
      target_group {
        name = local.alb_tg_blue_name 
      }
      target_group {
        name = local.alb_tg_green_name 
      }
      test_traffic_route {
        listener_arns = [local.alb_listener_arn_green]

     }
    }
  }
}


