resource "aws_lb" "sdkim_alb" {
  name = "${var.name}-alb"
  internal = false
  load_balancer_type = var.lb_type
  security_groups = [aws_security_group.sdkim_sg.id]
  subnets = [aws_subnet.sdkim_pub[0].id,aws_subnet.sdkim_pub[1].id]
  tags = {
      "Name" = "${var.name}-alb"
  }
}

output "dns_name" {
  value = aws_lb.sdkim_alb.dns_name
}

resource "aws_lb_target_group" "sdkim-albtg" {
  name     = "${var.name}-albtg"
  port     = var.port_http
  protocol = var.pro_HTTP
  vpc_id   = aws_vpc.sdkim_vpc.id

  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 5
    matcher             = "200"
    path                = "/health.html"
    port                = "traffic-port"
    protocol            = var.pro_HTTP
    timeout             = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "sdkim_albis" {
  load_balancer_arn = aws_lb.sdkim_alb.arn
  port = var.port_http
  protocol = var.pro_HTTP

  default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.sdkim-albtg.arn
  }
}

resource "aws_lb_target_group_attachment" "sdkim_albtgatt" {
  target_group_arn = aws_lb_target_group.sdkim-albtg.arn
  target_id = aws_instance.sdkim_web.id
  port = var.port_http
}