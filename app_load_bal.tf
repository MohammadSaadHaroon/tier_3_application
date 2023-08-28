resource "aws_lb" "tier_alb" {
  name               = "tier-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_tls.id]
  subnets            = [for subnet in aws_subnet.tier_public : subnet.id]

  enable_deletion_protection = false

  tags = {
    Environment = "test"
  }

}

#Target Group

resource "aws_lb_target_group" "tier_tg_group" {
  name        = "targetgroup"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.main_vpc.id

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 10
    path                = "/"
    port                = 80
  }

}

#Listener
resource "aws_lb_listener" "tier_list" {
  load_balancer_arn = aws_lb.tier_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tier_tg_group.arn
  }

}