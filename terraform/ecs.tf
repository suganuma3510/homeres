variable "ecr_nuxt_image" {}

resource "aws_ecs_cluster" "ecs-cluster" {
  name = "ecs-cluster"
}

resource "aws_cloudwatch_log_group" "cloudwatch" {
  name = "cloudwatch"
  tags = {
    Application = "ecs"
  }
}

data "template_file" "container-definitions" {
  template = file("./tasks/nuxt_definition.json")
  vars = {
    ECR_ARN   = var.ecr_nuxt_image
    log_group = aws_cloudwatch_log_group.cloudwatch.name
  }
}

resource "aws_ecs_task_definition" "ecs-task" {
  family                   = "ecs-task"
  container_definitions    = data.template_file.container-definitions.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.task_execution.arn
  task_role_arn            = aws_iam_role.task_execution.arn
}

resource "aws_ecs_service" "ecs-service" {
  name            = "ecs-service"
  task_definition = aws_ecs_task_definition.ecs-task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  cluster         = aws_ecs_cluster.ecs-cluster.arn
  depends_on = [
    aws_lb.alb
  ]
  network_configuration {
    security_groups = [
      aws_security_group.ecs-service-sg.id
    ]
    subnets = [
      aws_subnet.private-1a.id,
      aws_subnet.private-1c.id
    ]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.alb-tg.arn
    container_name   = "homeres-nuxt-app"
    container_port   = "80"
  }
}

