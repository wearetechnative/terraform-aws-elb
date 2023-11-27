resource "aws_lb_listener" "http_listener" {
  count = !var.disable_default_listeners ? 1 : 0

  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "no routes available"
      status_code  = "503"
    }
  }
}

resource "aws_lb_listener_rule" "http_listener_https_redirect" {
  count        = length(aws_lb_listener.https_listener) > 0 ? 1 : 0
  listener_arn = aws_lb_listener.http_listener[0].arn
  priority     = 1

  action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }
}
