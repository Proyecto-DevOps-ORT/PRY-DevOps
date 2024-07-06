# # 4 Creo cluster
# resource "aws_ecs_cluster" "ecs-cluster" {
#   name = "ecs-cluster-backend"
# }

# resource "aws_ecs_service" "service-shipping" {
#   name = "service-pry-backend-shipping"
#   cluster = aws_ecs_cluster.ecs.arn
#   launch_type = "FARGATE"
#   enable_execute_command = true

#   deployment_maximum_percent = 200
#   deployment_minimum_healthy_percent = 100
#   desired_count = 1
#   #task_definition = aws_ecs_task_definition.td.arn

#   network_configuration {
#     security_groups = [aws_security_group.sg.id]
#     subnets = aws_subnet.subnet[*].id
#     assign_public_ip = true
#   }
# }

# resource "aws_ecs_task_definition" "td" {
#   container_definitions = jsonencode([
#     {
#       name = "container-pry-backend-shipping"
#       image = "${aws_ecr_repository.repo-shipping.repository_url}:latest" # aca va la uri de la imagen de ecr
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
#   family = "task-def-pry-backend-shipping"
#   requires_compatibilities = ["FARGATE"]
#   network_mode = "awsvpc"
#   execution_role_arn = aws_iam_role.ecsTaskExecutionRole.arn
#   task_role_arn = aws_iam_role.ecsTaskRole.arn
#   memory = "512"
#   cpu = "256"
# }

