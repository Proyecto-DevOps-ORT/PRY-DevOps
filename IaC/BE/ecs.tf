# # 4 Creo cluster
# resource "aws_ecs_cluster" "ecs-cluster" {
#   name = "ecs-cluster-backend"
# }
# resource "aws_ecs_service" "service-shipping" {
#   name = "service-shipping"
#   cluster = aws_ecs_cluster.ecs-cluster.arn
#   launch_type = "FARGATE"
#   enable_execute_command = true

#   deployment_maximum_percent = 200
#   deployment_minimum_healthy_percent = 100
#   desired_count = 1
#   task_definition = aws_ecs_task_definition.td.arn

#   network_configuration {
#     security_groups = [aws_security_group.security_group.id]
#     subnets = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
#     assign_public_ip = true
#   }
# }

# resource "aws_ecs_task_definition" "td" {
#   container_definitions = jsonencode([
#     {
#       name = "container-pry-backend-shipping"
#       image = "${aws_ecr_repository.repo-shipping.repository_url}:develop" # aca va la uri de la imagen de ecr #"317097728802.dkr.ecr.us-east-1.amazonaws.com/repo-pry-backend-shipping" 
#       cpu = 256
#       memory = 512
#       essential = true
#       portMappings = [
#         {
#           containerPort = 8080
#           hostPort = 8080
#         }
#       ]
#     }
#   ])
#   family = "task-def-shipping"
#   requires_compatibilities = ["FARGATE"]
#   network_mode = "awsvpc"
#   execution_role_arn = var.rol-lab #aws_iam_role.ecsTaskExecutionRole.arn --Lo saque de IAM => roles
#   task_role_arn = var.rol-lab #aws_iam_role.ecsTaskRole.arn --Lo saque de IAM => roles
#   memory = "512"
#   cpu = "256"
# }



