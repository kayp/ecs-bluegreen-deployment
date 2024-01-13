resource "aws_ecs_cluster" "ecs-cluster" {
  name = var.application_name
}


resource "aws_ecs_service" "ecs-service" {
  name            = var.application_name
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.ecs-task-def.arn
  desired_count = "1"
  launch_type = "FARGATE"
  scheduling_strategy = "REPLICA"
  deployment_controller {
    type = "CODE_DEPLOY"
  }
  load_balancer {
    target_group_arn = local.alb_tg_blue_arn
    container_name = var.container_image_blue
    container_port = 80
  }
  network_configuration {
  subnets = var.subnet_ids
  security_groups = [local.alb_sg_id]
  assign_public_ip = true
  }
}

resource "aws_ecs_task_definition" "ecs-task-def" {
  family = var.application_name
  memory = "512"
  cpu = "256"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn = local.ecs_task_execution_role
  container_definitions = <<DEFINITION
[
 {
            "name": "${var.application_name}",
            "image":  "${var.image_uri}",
            "essential": true,
            "portMappings": [
                {
                    "hostPort": 80,
                    "protocol": "tcp",
                    "containerPort": 80
                }
            ]
 }
]
DEFINITION
}


locals {
  ecs_cluster_name = aws_ecs_cluster.ecs-cluster.name
  ecs_service_name = aws_ecs_service.ecs-service.name
}
