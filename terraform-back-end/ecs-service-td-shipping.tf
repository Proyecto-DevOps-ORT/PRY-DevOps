######################################################################################################################################
###############     PRODUCCION   ########################################################################################################

resource "aws_ecs_service" "service-shipping-prod" {
  name = "service-shipping-produccion"
  cluster = aws_ecs_cluster.ecs-cluster.arn
  launch_type = "FARGATE"
  enable_execute_command = true

  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 100
  desired_count = 1
  task_definition = aws_ecs_task_definition.td-shipping-produccion.arn

  network_configuration {
    security_groups = [aws_security_group.security_group.id]
    subnets = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
    assign_public_ip = true
  }

  #  load_balancer {
	# target_group_arn = aws_lb_target_group.ecs_tg_prod.arn
	# container_name   = "container-pry-backend-shipping"
	# container_port   = 8080
  # }
}

resource "aws_ecs_task_definition" "td-shipping-produccion" {
  container_definitions = jsonencode([
    {
      name = "container-pry-backend-shipping"
      image = "${aws_ecr_repository.repo-shipping.repository_url}:latest" # aca va la uri de la imagen de ecr #"317097728802.dkr.ecr.us-east-1.amazonaws.com/repo-pry-backend-shipping" 
      cpu = 256
      memory = 512
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort = 8080
        }
      ]
    }
  ])
  family = "task-def-shipping-produccion"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  execution_role_arn = "arn:aws:iam::317097728802:role/LabRole" #aws_iam_role.ecsTaskExecutionRole.arn --Lo saque de IAM => roles
  task_role_arn = "arn:aws:iam::317097728802:role/LabRole" #aws_iam_role.ecsTaskRole.arn --Lo saque de IAM => roles
  memory = "512"
  cpu = "256"
}

######################################################################################################################################
###############     STAGING   ########################################################################################################

resource "aws_ecs_service" "service-shipping-stage" {
  name = "service-shipping-stage"
  cluster = aws_ecs_cluster.ecs-cluster.arn
  launch_type = "FARGATE"
  enable_execute_command = true

  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 100
  desired_count = 1
  task_definition = aws_ecs_task_definition.td-shipping-stage.arn

  network_configuration {
    security_groups = [aws_security_group.security_group.id]
    subnets = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
    assign_public_ip = true
  }
  # load_balancer {
	# target_group_arn = aws_lb_target_group.ecs_tg_stage.arn
	# container_name   = "container-pry-backend-shipping"
	# container_port   = 8080
  # }
}

resource "aws_ecs_task_definition" "td-shipping-stage" {
  container_definitions = jsonencode([
    {
      name = "container-pry-backend-shipping"
      image = "${aws_ecr_repository.repo-shipping.repository_url}:staging" # aca va la uri de la imagen de ecr #"317097728802.dkr.ecr.us-east-1.amazonaws.com/repo-pry-backend-shipping" 
      cpu = 256
      memory = 512
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort = 8080
        }
      ]
    }
  ])
  family = "task-def-shipping-stage"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  execution_role_arn = "arn:aws:iam::317097728802:role/LabRole" #aws_iam_role.ecsTaskExecutionRole.arn --Lo saque de IAM => roles
  task_role_arn = "arn:aws:iam::317097728802:role/LabRole" #aws_iam_role.ecsTaskRole.arn --Lo saque de IAM => roles
  memory = "512"
  cpu = "256"
}

######################################################################################################################################
###############     DEVELOP   ########################################################################################################
resource "aws_ecs_service" "service-shipping-dev" {
  name = "service-shipping-dev"
  cluster = aws_ecs_cluster.ecs-cluster.arn
  launch_type = "FARGATE"
  enable_execute_command = true

  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 100
  desired_count = 1
  task_definition = aws_ecs_task_definition.td-shipping-dev.arn

  network_configuration {
    security_groups = [aws_security_group.security_group.id]
    subnets = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
    assign_public_ip = true
  }

  # load_balancer {
	# target_group_arn = aws_lb_target_group.ecs_tg_dev.arn
	# container_name   = "container-pry-backend-shipping"
	# container_port   = 8080
  # }
}

resource "aws_ecs_task_definition" "td-shipping-dev" {
  container_definitions = jsonencode([
    {
      name = "container-pry-backend-shipping"
      image = "${aws_ecr_repository.repo-shipping.repository_url}:develop" # aca va la uri de la imagen de ecr #"317097728802.dkr.ecr.us-east-1.amazonaws.com/repo-pry-backend-shipping" 
      cpu = 256
      memory = 512
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort = 8080
        }
      ]
    }
  ])
  family = "task-def-shipping-dev"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  execution_role_arn = "arn:aws:iam::317097728802:role/LabRole" #aws_iam_role.ecsTaskExecutionRole.arn --Lo saque de IAM => roles
  task_role_arn = "arn:aws:iam::317097728802:role/LabRole" #aws_iam_role.ecsTaskRole.arn --Lo saque de IAM => roles
  memory = "512"
  cpu = "256"
}



