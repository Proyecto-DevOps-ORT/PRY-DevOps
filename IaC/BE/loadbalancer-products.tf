########### ALB #######################################################

# Define the Application Load Balancer products
resource "aws_lb" "ecs_alb_products" {
  name                       = "ecs-alb-products"
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

# Target Group for service-products-prod
resource "aws_lb_target_group" "ecs_tg_products_prod" {
  name        = "ecs-products-tg-prod"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip" # Ensure this is set to 'ip' for compatibility with awsvpc network mode
  health_check {
    path                = "/products"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 300
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Target Group for service-products-stage
resource "aws_lb_target_group" "ecs_tg_products_stage" {
  name        = "ecs-products-tg-stage"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip"
  health_check {
    path                = "/products"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 300
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Target Group for service-products-dev
resource "aws_lb_target_group" "ecs_tg_products_dev" {
  name        = "ecs-products-tg-dev"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip"
   health_check {
    path                = "/products"
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
resource "aws_lb_listener" "ecs_listener_products" {
  load_balancer_arn = aws_lb.ecs_alb_products.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg_products_dev.arn # Default action, can be adjusted based on requirements
  }
}

########### LISTENER RULES #######################################################

# Listener Rule for service-products-prod
resource "aws_lb_listener_rule" "prod_products" {
  listener_arn = aws_lb_listener.ecs_listener_products.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg_products_prod.arn
  }

  condition {
    path_pattern {
      values = ["/prod/"]
    }
  }
}

# Listener Rule for service-products-dev
resource "aws_lb_listener_rule" "dev_products" {
  listener_arn = aws_lb_listener.ecs_listener_products.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg_products_dev.arn
  }

  condition {
    path_pattern {
      values = ["/dev/*"]
    }
  }
}

# Listener Rule for service-products-stage
resource "aws_lb_listener_rule" "stage_products" {
  listener_arn = aws_lb_listener.ecs_listener_products.arn
  priority     = 150

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg_products_stage.arn
  }

  condition {
    path_pattern {
      values = ["/stage/*"]
    }
  }
}




