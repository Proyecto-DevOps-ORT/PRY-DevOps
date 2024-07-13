# 4 Creo cluster
resource "aws_ecs_cluster" "ecs-cluster" {
  name = "ecs-cluster-backend"
}