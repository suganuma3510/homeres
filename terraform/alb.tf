resource "aws_lb_target_group" "alb-tg" {
  name        = "alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 150
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    matcher             = "200-299"
    timeout             = 120
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "go-alb-tg" {
  name        = "go-alb-tg"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 150
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    matcher             = "200-299"
    timeout             = 120
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb" "alb" {
  name               = "alb"
  load_balancer_type = "application"
  subnets = [
    aws_subnet.public-1a.id,
    aws_subnet.public-1c.id
  ]
  security_groups = [
    aws_security_group.alb-sg.id
  ]
  tags = {
    Name = "alb"
  }
}

/* resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.certificate.arn

  default_action {
    target_group_arn = aws_lb_target_group.alb-tg.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "api_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 3000
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.certificate.arn

  default_action {
    target_group_arn = aws_lb_target_group.go-alb-tg.arn
    type             = "forward"
  }
} */

resource "aws_lb_listener" "blog_http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.alb-tg.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "api_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 3000
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.go-alb-tg.arn
    type             = "forward"
  }
}