########### ALB #######################################################

# Define the Application Load Balancer payments
resource "aws_lb" "ecs_alb_payments" {
  name                       = "ecs-alb-payments"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb_sg.id]
  subnets                    = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  enable_deletion_protection = false

  tags = {
    Name = "ecs-alb"
  }
}

########### TARGET GROUPS #######################################################

# Target Group for service-payments-prod
resource "aws_lb_target_group" "ecs_tg_payments_prod" {
  name        = "ecs-payments-tg-prod"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip" # Ensure this is set to 'ip' for compatibility with awsvpc network mode
  health_check {
    path                = "/payments"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 300
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Target Group for service-payments-stage
resource "aws_lb_target_group" "ecs_tg_payments_stage" {
  name        = "ecs-payments-tg-stage"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip"
  health_check {
    path                = "/payments"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 300
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Target Group for service-payments-dev
resource "aws_lb_target_group" "ecs_tg_payments_dev" {
  name        = "ecs-payments-tg-dev"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip"
   health_check {
    path                = "/payments"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 300
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

########### LISTENER #######################################################

# Listener for the ALB
resource "aws_lb_listener" "ecs_listener_payments" {
  load_balancer_arn = aws_lb.ecs_alb_payments.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg_payments_dev.arn # Default action, can be adjusted based on requirements
  }
}

########### LISTENER RULES #######################################################

# Listener Rule for service-payments-prod
resource "aws_lb_listener_rule" "prod_payments" {
  listener_arn = aws_lb_listener.ecs_listener_payments.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg_payments_prod.arn
  }

  condition {
    path_pattern {
      values = ["/prod/"]
    }
  }
}

# Listener Rule for service-payments-dev
resource "aws_lb_listener_rule" "dev_payments" {
  listener_arn = aws_lb_listener.ecs_listener_payments.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg_payments_dev.arn
  }

  condition {
    path_pattern {
      values = ["/dev/*"]
    }
  }
}

# Listener Rule for service-payments-stage
resource "aws_lb_listener_rule" "stage_payments" {
  listener_arn = aws_lb_listener.ecs_listener_payments.arn
  priority     = 150

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg_payments_stage.arn
  }

  condition {
    path_pattern {
      values = ["/stage/*"]
    }
  }
}




