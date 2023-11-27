resource "aws_lb_listener" "https_listener" {
  count = !var.disable_default_listeners && var.default_certificate_arn != null ? 1 : 0

  load_balancer_arn = aws_lb.this.arn
  port              = 443
  protocol          = "HTTPS"
  # alpn_policy
  certificate_arn = var.default_certificate_arn
  ssl_policy      = "ELBSecurityPolicy-TLS-1-1-2017-01" # like default (ELBSecurityPolicy-2016-08) but without TLS 1.0

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "no routes available"
      status_code  = "503"
    }
  }
}
