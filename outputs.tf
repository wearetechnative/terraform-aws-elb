output "lb_https_listener_arn" {
  value = length(aws_lb_listener.https_listener) > 0 ? aws_lb_listener.https_listener[0].arn : null
}

output "lb_http_listener_arn" {
  value = length(aws_lb_listener.http_listener) > 0 ? aws_lb_listener.http_listener[0].arn : null
}

output "lb_arn" {
  value = aws_lb.this.arn
}

output "lb_dns_name" {
  value = aws_lb.this.dns_name
}

output "lb_zone_id" {
  value = aws_lb.this.zone_id
}
