########### ALB #######################################################

# Define the Application Load Balancer
resource "aws_lb" "ecs_alb" {
  name                       = "ecs-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb_sg.id]
  subnets                    = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  enable_deletion_protection = false

  tags = {
    Name = "ecs-alb"
  }
}

########### SECURITY GROUP - ALB #######################################################

# Security group for the ALB
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

########### TARGET GROUPS #######################################################

# Target Group for service-shipping-prod
resource "aws_lb_target_group" "ecs_tg_prod" {
  name        = "ecs-tg-prod"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip" # Ensure this is set to 'ip' for compatibility with awsvpc network mode
  health_check {
    path                = "/shipping/c"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 300
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Target Group for service-shipping-stage
resource "aws_lb_target_group" "ecs_tg_stage" {
  name        = "ecs-tg-stage"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip"
  health_check {
    path                = "/shipping/c"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 300
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Target Group for service-shipping-dev
resource "aws_lb_target_group" "ecs_tg_dev" {
  name        = "ecs-tg-dev"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip"
   health_check {
    path                = "/shipping/c"
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
resource "aws_lb_listener" "ecs_listener" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg_dev.arn # Default action, can be adjusted based on requirements
  }
}

########### LISTENER RULES #######################################################

# Listener Rule for service-shipping-prod
resource "aws_lb_listener_rule" "prod" {
  listener_arn = aws_lb_listener.ecs_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg_prod.arn
  }

  condition {
    path_pattern {
      values = ["/prod/"]
    }
  }
}

# Listener Rule for service-shipping-dev
resource "aws_lb_listener_rule" "dev" {
  listener_arn = aws_lb_listener.ecs_listener.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg_dev.arn
  }

  condition {
    path_pattern {
      values = ["/dev/*"]
    }
  }
}

# Listener Rule for service-shipping-stage
resource "aws_lb_listener_rule" "stage" {
  listener_arn = aws_lb_listener.ecs_listener.arn
  priority     = 150

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg_stage.arn
  }

  condition {
    path_pattern {
      values = ["/stage/*"]
    }
  }
}



