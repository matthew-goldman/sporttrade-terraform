variable "vpc_id" {
  description = "The vpc id to attach the sg to"
  type        = string
}

variable "tags" {
  description = "The tags to be added to the sg"
  type        = map
}
