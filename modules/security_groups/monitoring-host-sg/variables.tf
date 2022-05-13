variable "vpc_id" {
  description = "The vpc id to attach the security group to"
  type        = string
}

variable "bastion_host_sg_id" {
  description = "The id of the bastion security group"
  type        = string
}

variable "cidr_blocks" {
  description = "The CIDR blocks that should be allowed for HTTPS traffic"
  type        = list
}

variable "tags" {
  description = "The tags to be added to the security group"
  type        = map
}


# variable "monitoring_lb_sg_id" {
#   description = "ID of the mgmt-services ALB"
#   type        = string
# }

variable "vpc_cidr" {
  description = "CIDR of VPC"
  type        = string
}