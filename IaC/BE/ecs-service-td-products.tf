######################################################################################################################################
###############     PRODUCCION   ########################################################################################################

resource "aws_ecs_service" "service-products-prod" {
  name = "service-products-produccion"
  cluster = aws_ecs_cluster.ecs-cluster.arn
  launch_type = "FARGATE"
  enable_execute_command = true

  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 100
  desired_count = 1
  task_definition = aws_ecs_task_definition.td-products-produccion.arn

  network_configuration {
    security_groups = [aws_security_group.security_group.id]
    subnets = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
    assign_public_ip = true
  }
}

resource "aws_ecs_task_definition" "td-products-produccion" {
  container_definitions = jsonencode([
    {
      name = "container-pry-backend-products"
      image = "${aws_ecr_repository.repo-products.repository_url}:latest" # aca va la uri de la imagen de ecr #"317097728802.dkr.ecr.us-east-1.amazonaws.com/repo-pry-backend-products" 
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
  family = "task-def-products-produccion"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  execution_role_arn = var.rol-lab #aws_iam_role.ecsTaskExecutionRole.arn --Lo saque de IAM => roles
  task_role_arn = var.rol-lab #aws_iam_role.ecsTaskRole.arn --Lo saque de IAM => roles
  memory = "512"
  cpu = "256"
}

######################################################################################################################################
###############     STAGING   ########################################################################################################

resource "aws_ecs_service" "service-products-stage" {
  name = "service-products-stage"
  cluster = aws_ecs_cluster.ecs-cluster.arn
  launch_type = "FARGATE"
  enable_execute_command = true

  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 100
  desired_count = 1
  task_definition = aws_ecs_task_definition.td-products-stage.arn

  network_configuration {
    security_groups = [aws_security_group.security_group.id]
    subnets = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
    assign_public_ip = true
  }
}

resource "aws_ecs_task_definition" "td-products-stage" {
  container_definitions = jsonencode([
    {
      name = "container-pry-backend-products"
      image = "${aws_ecr_repository.repo-products.repository_url}:staging" # aca va la uri de la imagen de ecr #"317097728802.dkr.ecr.us-east-1.amazonaws.com/repo-pry-backend-products" 
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
  family = "task-def-products-stage"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  execution_role_arn = var.rol-lab #aws_iam_role.ecsTaskExecutionRole.arn --Lo saque de IAM => roles
  task_role_arn = var.rol-lab #aws_iam_role.ecsTaskRole.arn --Lo saque de IAM => roles
  memory = "512"
  cpu = "256"
}

######################################################################################################################################
###############     DEVELOP   ########################################################################################################
resource "aws_ecs_service" "service-products-dev" {
  name = "service-products-dev"
  cluster = aws_ecs_cluster.ecs-cluster.arn
  launch_type = "FARGATE"
  enable_execute_command = true

  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 100
  desired_count = 1
  task_definition = aws_ecs_task_definition.td-products-dev.arn

  network_configuration {
    security_groups = [aws_security_group.security_group.id]
    subnets = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
    assign_public_ip = true
  }
}

resource "aws_ecs_task_definition" "td-products-dev" {
  container_definitions = jsonencode([
    {
      name = "container-pry-backend-products"
      image = "${aws_ecr_repository.repo-products.repository_url}:develop" # aca va la uri de la imagen de ecr #"317097728802.dkr.ecr.us-east-1.amazonaws.com/repo-pry-backend-products" 
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
  family = "task-def-products-dev"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  execution_role_arn = var.rol-lab #aws_iam_role.ecsTaskExecutionRole.arn --Lo saque de IAM => roles
  task_role_arn = var.rol-lab #aws_iam_role.ecsTaskRole.arn --Lo saque de IAM => roles
  memory = "512"
  cpu = "256"
}



