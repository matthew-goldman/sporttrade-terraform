variable "vpc_id" {
  description = "The vpc id to attach the security group to"
  type        = string
}

variable "monitoring_host_sg_id" {
  description = "The id of the monitoring host security group"
  type        = string
}

variable "tags" {
  description = "The tags to be added to the security group"
  type        = map
}
