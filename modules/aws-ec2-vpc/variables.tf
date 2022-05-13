variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "0.0.0.0/0"
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "aws_region" {
  description = "The aws region will be prefixed to the az names (region-a, region-b, region-c)"
  type        = string
  default     = ""
}

variable "tags" {
    description = "A map of tags to add to all resources"
    type        = map
    default     = {}
}
