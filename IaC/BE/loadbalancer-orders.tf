########### ALB #######################################################

# Define the Application Load Balancer Orders
resource "aws_lb" "ecs_alb_orders" {
  name                       = "ecs-alb-orders"
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

# Target Group for service-orders-prod
resource "aws_lb_target_group" "ecs_tg_orders_prod" {
  name        = "ecs-orders-tg-prod"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip" # Ensure this is set to 'ip' for compatibility with awsvpc network mode
  health_check {
    path                = "/orders"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 300
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Target Group for service-orders-stage
resource "aws_lb_target_group" "ecs_tg_orders_stage" {
  name        = "ecs-orders-tg-stage"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip"
  health_check {
    path                = "/orders"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 300
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Target Group for service-orders-dev
resource "aws_lb_target_group" "ecs_tg_orders_dev" {
  name        = "ecs-orders-tg-dev"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip"
   health_check {
    path                = "/orders"
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
resource "aws_lb_listener" "ecs_listener_orders" {
  load_balancer_arn = aws_lb.ecs_alb_orders.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg_orders_dev.arn # Default action, can be adjusted based on requirements
  }
}

########### LISTENER RULES #######################################################

# Listener Rule for service-orders-prod
resource "aws_lb_listener_rule" "prod_orders" {
  listener_arn = aws_lb_listener.ecs_listener_orders.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg_orders_prod.arn
  }

  condition {
    path_pattern {
      values = ["/prod/"]
    }
  }
}

# Listener Rule for service-orders-dev
resource "aws_lb_listener_rule" "dev_orders" {
  listener_arn = aws_lb_listener.ecs_listener_orders.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg_orders_dev.arn
  }

  condition {
    path_pattern {
      values = ["/dev/*"]
    }
  }
}

# Listener Rule for service-orders-stage
resource "aws_lb_listener_rule" "stage_orders" {
  listener_arn = aws_lb_listener.ecs_listener_orders.arn
  priority     = 150

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg_orders_stage.arn
  }

  condition {
    path_pattern {
      values = ["/stage/*"]
    }
  }
}




