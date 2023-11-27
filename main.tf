resource "aws_lb" "this" {
  name     = local.name
  internal = !var.external_facing

  load_balancer_type         = local.load_balancer_type
  security_groups            = var.security_groups
  drop_invalid_header_fields = local.load_balancer_type == "application" ? true : false

  access_logs {
    enabled = true
    bucket  = data.aws_arn.bucket_logs.resource
    prefix  = ""
  }

  subnets = var.subnets
  # subnet_mapping {}

  idle_timeout                     = 60
  enable_cross_zone_load_balancing = local.load_balancer_type == "network" ? true : false
  enable_http2                     = local.load_balancer_type == "application" ? true : false
  enable_waf_fail_open             = false
  # customer_owned_ipv4_pool
  ip_address_type        = "ipv4"
  desync_mitigation_mode = !var.disable_strict_desync_mitigation_mode ? "strictest" : "defensive"
}
