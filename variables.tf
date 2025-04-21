variable "name" {
  description = "Unique name for ALB."
  type        = string
}

variable "security_groups" {
  description = "Security groups to assign. Inbound ports will be added by the module."
  type        = list(string)
}

variable "subnets" {
  description = "Public subnets with an internet gateway for LB traffic."
  type        = list(string)
}

variable "default_certificate_arn" {
  description = "Required default certificate ARN. Requirement for the SSL listener otherwise no SSL listener is created."
  type        = string
  default     = null
}

variable "external_facing" {
  description = "If set to true then the load balancer will be available from the internet and an HTTPS listener will be created."
  type        = bool
  default     = false
}

variable "disable_default_listeners" {
  description = "Don't use listeners from this module."
  type        = bool
  default     = false
}

variable "disable_strict_desync_mitigation_mode" {
  description = "Set to true only if you intent to use this load balancer with an API Gateway over VPC Link."
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "Type of load balancer. Can be application or network."
  type        = string
  default     = "application"
}
