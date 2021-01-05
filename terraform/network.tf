resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc"
  }
}

resource "aws_subnet" "public-1a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-1a"
  }
}

resource "aws_subnet" "private-1a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "private-1a"
  }
}

resource "aws_subnet" "public-1c" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-1c"
  }
}

resource "aws_subnet" "private-1c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-northeast-1c"
  tags = {
    Name = "private-1c"
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "ig"
  }
}

resource "aws_eip" "nat-eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.ig]
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.public-1a.id
  depends_on    = [aws_internet_gateway.ig]
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "rtb-public-1a" {
  subnet_id      = aws_subnet.public-1a.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "rtb-public-1c" {
  subnet_id      = aws_subnet.public-1c.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "rtb-private-1a" {
  subnet_id      = aws_subnet.private-1a.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "rtb-private-1c" {
  subnet_id      = aws_subnet.private-1c.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_security_group" "alb-sg" {
  name        = "alb-sg"
  description = "ALB security group for blog"
  vpc_id      = aws_vpc.vpc.id
}

resource "aws_security_group" "ecs-service-sg" {
  vpc_id      = aws_vpc.vpc.id
  name        = "ecs-service-sg"
  description = "ECS service security group for blog"
}

resource "aws_security_group_rule" "alb-sg-rule1" {
  description       = "alb-sg-rule1"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb-sg.id
}

resource "aws_security_group_rule" "alb-sg-rule2" {
  description       = "alb-sg-rule2"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb-sg.id
}

resource "aws_security_group_rule" "alb-sg-rule3" {
  description       = "alb-sg-rule3"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb-sg.id
}

resource "aws_security_group_rule" "ecs-service-sg-rule1" {
  description       = "ecs-service-sg-rule1"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs-service-sg.id
}

resource "aws_security_group_rule" "ecs-service-sg-rule2" {
  description       = "ecs-service-sg-rule2"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs-service-sg.id
}
