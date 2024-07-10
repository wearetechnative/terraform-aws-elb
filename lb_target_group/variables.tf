variable "name" {
  description = "Unique name for the service within the ECS cluster."
  type        = string
}

variable "healthcheck_path" {
  description = "URL subpath for healthcheck e.g. /status. Optional, can be set to null to disable."
  type        = string
  default     = null
}

variable "target_container_port" {
  description = "Port of the container that is the load balancer entrypoint. Optional if you use ECS with dynamoc port allocation."
  type        = number
  default     = null
}

variable "vpc_id" {
  description = "Network VPC to host target group in."
  type        = string
}

variable "healthcheck_matcher" {
  description = "Healthcheck codes matches, defaults to 200 only."
  type        = list(number)
  default     = [200]
}

variable "healtcheck_port" {
  description = "Optional port to override traffic-port for healthchecks."
  type        = number
  default     = null
}

variable "target_type" {
  description = "Port of the container that is the load balancer entrypoint. Optional if you use ECS with dynamoc port allocation."
  type        = string
  default     = "instance"
}
