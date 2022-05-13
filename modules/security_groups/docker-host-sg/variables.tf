variable "vpc_id" {
  description = "The vpc id to attach the security group to"
  type        = string
}

variable "bastion_host_sg_id" {
  description = "The id of the bastion security group"
  type        = string
}

variable "tags" {
  description = "The tags to be added to the security group"
  type        = map
}

variable "docker_alb_sg_id" {
  description = "The security group of the ALB associated with Docker"
  type        = string
}
