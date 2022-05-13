variable "hosted_zone_name" {
  description = "The name of the hosted zone to be created"
  type        = string
}

variable "vpc_id" {
  description = "The vpc id to attach the private hosted zone to"
  type        = string
}

variable "vpc_aws_region" {
  description = "The aws region of the vpc to associate with the private hosted zone"
  type        = string
}

variable "tags" {
  description = "The tags to be assigned to the hosted zones"
  type        = map
  default     = {}
}
