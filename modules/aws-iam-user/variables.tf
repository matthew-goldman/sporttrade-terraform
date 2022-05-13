variable "user_name" {}

variable "path" {
  default = "/"
}

variable "permission_boundary" {
  default = ""
}

variable force_destroy {
  default = false
}

variable tags {
  default = ""
}

variable "policy_name" {
  default = ""
}

variable "s3_bucket_arn" {
  default = ""
}
