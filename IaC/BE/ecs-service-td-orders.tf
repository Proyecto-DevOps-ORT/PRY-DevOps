######################################################################################################################################
###############     PRODUCCION   ########################################################################################################

resource "aws_ecs_service" "service-orders-prod" {
  name = "service-orders-produccion"
  cluster = aws_ecs_cluster.ecs-cluster.arn
  launch_type = "FARGATE"
  enable_execute_command = true

  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 100
  desired_count = 1
  task_definition = aws_ecs_task_definition.td-orders-produccion.arn

  network_configuration {
    security_groups = [aws_security_group.security_group.id]
    subnets = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
    assign_public_ip = true
  }
}

resource "aws_ecs_task_definition" "td-orders-produccion" {
  container_definitions = jsonencode([
    {
      name = "container-pry-backend-orders"
      image = "${aws_ecr_repository.repo-orders.repository_url}:latest" # aca va la uri de la imagen de ecr #"317097728802.dkr.ecr.us-east-1.amazonaws.com/repo-pry-backend-orders" 
      cpu = 256
      memory = 512
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort = 8080
        }
      ]
      environment = [
        {
          name = "APP_ARGS"
          value = "http://172.17.0.2:8080 http://172.17.0.4:8080 http://172.17.0.3:8080"
        }
        // aca podria agregar mas variables de entorno
      ]
    }
  ])
  family = "task-def-orders-produccion"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  execution_role_arn = "arn:aws:iam::753480294298:role/LabRole" #aws_iam_role.ecsTaskExecutionRole.arn --Lo saque de IAM => roles
  task_role_arn = "arn:aws:iam::753480294298:role/LabRole" #aws_iam_role.ecsTaskRole.arn --Lo saque de IAM => roles
  memory = "512"
  cpu = "256"
}

######################################################################################################################################
###############     STAGING   ########################################################################################################

resource "aws_ecs_service" "service-orders-stage" {
  name = "service-orders-stage"
  cluster = aws_ecs_cluster.ecs-cluster.arn
  launch_type = "FARGATE"
  enable_execute_command = true

  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 100
  desired_count = 1
  task_definition = aws_ecs_task_definition.td-orders-stage.arn

  network_configuration {
    security_groups = [aws_security_group.security_group.id]
    subnets = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
    assign_public_ip = true
  }
}

resource "aws_ecs_task_definition" "td-orders-stage" {
  container_definitions = jsonencode([
    {
      name = "container-pry-backend-orders"
      image = "${aws_ecr_repository.repo-orders.repository_url}:staging" # aca va la uri de la imagen de ecr #"317097728802.dkr.ecr.us-east-1.amazonaws.com/repo-pry-backend-orders" 
      cpu = 256
      memory = 512
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort = 8080
        }
      ]
      environment = [
        {
          name = "APP_ARGS"
          value = "http://172.17.0.2:8080 http://172.17.0.4:8080 http://172.17.0.3:8080"
        }
        // aca podria agregar mas variables de entorno
      ]
    }
  ])
  family = "task-def-orders-stage"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  execution_role_arn = "arn:aws:iam::753480294298:role/LabRole" #aws_iam_role.ecsTaskExecutionRole.arn --Lo saque de IAM => roles
  task_role_arn = "arn:aws:iam::753480294298:role/LabRole" #aws_iam_role.ecsTaskRole.arn --Lo saque de IAM => roles
  memory = "512"
  cpu = "256"
}

######################################################################################################################################
###############     DEVELOP   ########################################################################################################
resource "aws_ecs_service" "service-orders-dev" {
  name = "service-orders-dev"
  cluster = aws_ecs_cluster.ecs-cluster.arn
  launch_type = "FARGATE"
  enable_execute_command = true

  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 100
  desired_count = 1
  task_definition = aws_ecs_task_definition.td-orders-dev.arn

  network_configuration {
    security_groups = [aws_security_group.security_group.id]
    subnets = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
    assign_public_ip = true
  }
}

resource "aws_ecs_task_definition" "td-orders-dev" {
  container_definitions = jsonencode([
    {
      name = "container-pry-backend-orders"
      image = "${aws_ecr_repository.repo-orders.repository_url}:develop" # aca va la uri de la imagen de ecr #"317097728802.dkr.ecr.us-east-1.amazonaws.com/repo-pry-backend-orders" 
      cpu = 256
      memory = 512
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort = 8080
        }
      ]
      environment = [
        {
          name = "APP_ARGS"
          value = "http://172.17.0.2:8080 http://172.17.0.4:8080 http://172.17.0.3:8080"
        }
        // aca podria agregar mas variables de entorno
      ]
    }
  ])
  family = "task-def-orders-dev"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  execution_role_arn = "arn:aws:iam::753480294298:role/LabRole" #aws_iam_role.ecsTaskExecutionRole.arn --Lo saque de IAM => roles
  task_role_arn = "arn:aws:iam::753480294298:role/LabRole" #aws_iam_role.ecsTaskRole.arn --Lo saque de IAM => roles
  memory = "512"
  cpu = "256"
}



