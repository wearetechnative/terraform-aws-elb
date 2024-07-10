resource "aws_lb_target_group" "this" {
  connection_termination = false
  deregistration_delay   = 30

  health_check {
    enabled = var.healthcheck_path != null ? true : false
    # fairly high interval to prevent DDos ing healthcheck port on each pod _on each AZ_ with cross-zone lbs(!)
    interval            = 60
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 2

    matcher = join(",", var.healthcheck_matcher)

    path     = var.healthcheck_path
    port     = var.healtcheck_port == null ? "traffic-port" : var.healtcheck_port
    protocol = "HTTP"
  }

  lambda_multi_value_headers_enabled = false
  load_balancing_algorithm_type      = "least_outstanding_requests"
  name_prefix                        = "${var.name}-"
  port                               = var.target_container_port == null ? 65535 : var.target_container_port
  # preserve_client_ip = false # nlb only
  protocol_version  = "HTTP1"
  protocol          = "HTTP"
  proxy_protocol_v2 = false # nlb only
  slow_start        = 0

  stickiness {
    enabled         = false
    cookie_duration = 86400 # 1 day
    type            = "lb_cookie"
  }

  target_type = var.target_type #var.target_container_port #!= null ? "instance" : "ip"
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }
}
