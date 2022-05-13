variable "vpc_id" {
  description = "The vpc id to attach the sg to"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR for the VPC internal addressing"
  type        = string
}

variable "tags" {
  description = "The tags to be added to the sg"
  type        = map
}

variable "cidr_blocks" {
  description = "The CIDR blocks that should be allowed for HTTPS traffic"
  type        = list
}
