variable "vpc_id" {
  description = "The vpc id to attach the security group to"
  type        = string
}

variable "ssh_cidr_blocks" {
  description = "The CIDR blocks that should be allowed for SSH traffic"
  type        = list
}

variable "tags" {
  description = "The tags to be added to the security group"
  type        = map
}
