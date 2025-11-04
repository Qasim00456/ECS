# ECS terraform

# Cluster
resource "aws_ecs_cluster" "ecs-cluster" {
  name = var.ecs_cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}


# Task definitons

resource "aws_ecs_task_definition" "threat_modelling_app" {
  family                   = var.ecs_task_family
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.ecs_task_cpu
  memory                   = var.ecs_task_memory

  execution_role_arn = var.execution_role_arn

  runtime_platform {
  operating_system_family = "LINUX"
  cpu_architecture        = "X86_64"
}


  container_definitions = jsonencode([
    {
      name      = "${var.ecs_container_name}"
      image     = "${var.ecs_container_image}"
      essential = true
      portMappings = [
        {
          containerPort = var.ecs_container_port
          hostPort      = var.ecs_host_port
          protocol      = "tcp"
        }
      ]
    }
  ])
}
# ECS service
resource "aws_ecs_service" "threat_model_app_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.threat_modelling_app.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = var.sg_id
    assign_public_ip = false
  }

  load_balancer {
  target_group_arn = var.target_group_arn
  container_name   = var.ecs_container_name
  container_port   = var.ecs_container_port
}
}

