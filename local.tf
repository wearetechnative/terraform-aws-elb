locals {
  #load_balancer_type = #"application"
  name               = join("", [var.external_facing ? "external-" : "", replace(var.name, "_", "-")])
}
