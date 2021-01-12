variable "ecr_nuxt_image" {}
variable "ecr_go_image" {}

resource "aws_ecs_cluster" "ecs-cluster" {
  name = "ecs-cluster"
}

resource "aws_cloudwatch_log_group" "cloudwatch" {
  name = "cloudwatch"
  tags = {
    Application = "ecs"
  }
}

data "template_file" "nuxt-container-definitions" {
  template = file("./tasks/nuxt_definition.json")
  vars = {
    ECR_ARN   = var.ecr_nuxt_image
    log_group = aws_cloudwatch_log_group.cloudwatch.name
  }
}

data "template_file" "go-container-definitions" {
  template = file("./tasks/go_definition.json")
  vars = {
    ECR_ARN   = var.ecr_go_image
    log_group = aws_cloudwatch_log_group.cloudwatch.name
  }
}

resource "aws_ecs_task_definition" "nuxt-ecs-task" {
  family                   = "ecs-task"
  container_definitions    = data.template_file.nuxt-container-definitions.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.task_execution.arn
  task_role_arn            = aws_iam_role.task_execution.arn
}

resource "aws_ecs_task_definition" "go-ecs-task" {
  family                   = "go-ecs-task"
  container_definitions    = data.template_file.go-container-definitions.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.task_execution.arn
  task_role_arn            = aws_iam_role.task_execution.arn
}

resource "aws_ecs_service" "nuxt-ecs-service" {
  name            = "ecs-service"
  task_definition = aws_ecs_task_definition.nuxt-ecs-task.arn
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

resource "aws_ecs_service" "go-ecs-service" {
  name            = "go-ecs-service"
  task_definition = aws_ecs_task_definition.go-ecs-task.arn
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
    target_group_arn = aws_lb_target_group.go-alb-tg.arn
    container_name   = "homeres-go-api"
    container_port   = "3000"
  }
}

