resource "aws_lb" "alb" {
  name               = var.application_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [ aws_security_group.alb_sec_grp.id]
  subnets            = var.subnet_ids

  enable_deletion_protection = false


  tags = {
    Name = var.application_name
  }
}


resource "aws_security_group" "alb_sec_grp" {
  name        =  "${var.application_name}-alb-sg"
  description = "ALB Security Group"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Security Group Rule for ALB Blue"
    from_port        = 80
    to_port          = 80
    cidr_blocks      = ["0.0.0.0/0"]
    protocol         = "tcp"
  }
  ingress {  
    description      = "Security Group Rule for ALB Green"
    from_port        = 8080
    to_port          = 8080
    cidr_blocks      = ["0.0.0.0/0"]
    protocol         = "tcp"
   }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        =  var.application_name
  }
}

resource "aws_lb_target_group" "alb_tg_blue" {
  name     = "alb-tg-blue"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"
}

resource "aws_lb_target_group" "alb_tg_green" {
  name     = "alb-tg-green"
  port     = "8080"
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"
}

resource "aws_lb_listener" "alb_listener_blue" {
  load_balancer_arn = aws_lb.alb.arn
  port = "80"
  protocol = "HTTP"
  default_action {
  type             = "forward"
  target_group_arn = aws_lb_target_group.alb_tg_blue.arn
  }
}
resource "aws_lb_listener" "alb_listener_green" {
  load_balancer_arn = aws_lb.alb.arn
  port = "8080"
  protocol = "HTTP"
  default_action {
  type             = "forward"
  target_group_arn = aws_lb_target_group.alb_tg_green.arn
  }
}

locals {
  alb_tg_blue_arn = aws_lb_target_group.alb_tg_blue.arn
  alb_tg_green_arn = aws_lb_target_group.alb_tg_green.arn
  alb_tg_blue_name = aws_lb_target_group.alb_tg_blue.name
  alb_tg_green_name = aws_lb_target_group.alb_tg_green.name
  alb_listener_arn_blue = aws_lb_listener.alb_listener_blue.arn
  alb_listener_arn_green = aws_lb_listener.alb_listener_green.arn
  alb_arn = aws_lb.alb.arn
  alb_sg_id = aws_security_group.alb_sec_grp.id
}


output alb_tg_arn  {
  value = local.alb_arn
  description = "The arn of the ALB"
}
