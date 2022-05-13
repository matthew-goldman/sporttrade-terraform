variable "alb_container_port" {
  description = "The port on which the container will receive traffic."
  default     = 443
  type        = string
}

variable "alb_health_check_protocol" {
  description = "The protocol that will be used for health checks.  Options are: TCP, HTTP, HTTPS"
  default     = "TCP"
  type        = string
}

variable "alb_health_check_port" {
  description = "The port on which the container will receive health checks."
  default     = 443
  type        = string
}

variable "alb_health_check_path" {
  description = "When using a HTTP(S) health check, the destination for the health check requests to the container."
  type        = string
  default     = "/"
}

variable "territory" {
  description = "Territory tag, e.g ut/am/us"
  type        = string
}

variable "alb_enable_proxy_protocol_v2" {
  description = "Boolean to enable / disable support for proxy protocol v2."
  default     = "true"
  type        = string
}

variable "alb_enable_cross_zone_load_balancing" {
  description = "If true, cross-zone load balancing of the load balancer will be enabled."
  default     = true
  type        = string
}

variable "alb_name" {
  description = "The service name"
  type        = string
}

# variable "alb_eip_ids" {
#   description = "List of Elastic IP allocation IDs to associate with the alb. Requires exactly 3 IPs."
#   type        = list
# }

variable "alb_listener_port" {
  description = "The port on which the alb will receive traffic."
  default     = "1"
  type        = string
}

variable "alb_subnet_ids" {
  description = "Subnets IDs for the alb."
  type        = list
}

variable "alb_vpc_id" {
  description = "VPC ID to be used by the alb."
  type        = string
}

variable "alb_enable_access_logs" {
  description = "To enable access logs"
  type        = bool
  default     = false
}

variable "alb_deletion_protection" {
  description = "Enable Deletion Protection"
  type        = bool
  default     = false
}

variable "alb_internal" {
  description = "Determine if alb is internal or not"
  type        = bool
  default     = false
}

variable "alb_docker_host_target_id" {
  description = "The target of the docker ALB rule"
  type        = list
}

variable "aws_lb_target_type" {
  description = "What type of target attachment to use"
  type        = string
  default     = "instance"
}

variable "certificate_arn" {
  description = "ARN of Certificate to use"
  type        = string
  default     = ""
}

variable "alb_listener_protocol" {
  description = "Protocol to use on the listener"
  type        = string
  default     = "TCP"
}

variable "alb_forward_port" {
  description = "Port to forward to"
  type        = string
  default     = ""
}

variable "alb_forward_protocol" {
  description = "Protocol to use in forwarding"
  type        = string
  default     = ""
}

variable "security_groups" {
  description = "List of security groups to attach"
  type        = list(string)
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "log_bucket_id" {
  description = "S3 bucket id for logs"
  type        = string
}

variable "docker_host_port" {
  description = "Port which the docker instance is listening on"
  type        = string
  default     = 80
}

variable "docker_host_protocol" {
  description = "Protocol the docker instance is using"
  type        = string
  default     = "HTTP"
}

variable "alb_docker_host_target_count" {
  description = "To enable the docker target attachment only when docker host is present"
  type        = string
}
