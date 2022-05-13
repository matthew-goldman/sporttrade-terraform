variable "create_certificate" {
  description = "Bool to enable certificate creation"
  type        = bool
  default     = false
}

variable "domain_name" {
    description = "Domain name to use"
    type        = string
}

variable "zone_id" {
    description = "Route 53 Zone ID to use"
    type        = string
}

variable "subject_alternative_names" {
    description = "Alternative names for ACM"
    type        = list(string)
    default     = []
}

variable "territory" {
    description = "Territory for ACM"
    type        = string
    default     = ""
}

variable "validate_certificate" {
  description = "Whether to validate certificate by creating Route53 record"
  type        = bool
  default     = true
}

variable "validation_allow_overwrite_records" {
  description = "Whether to allow overwrite of Route53 records"
  type        = bool
  default     = true
}

variable "wait_for_validation" {
  description = "Whether to wait for the validation to complete"
  type        = bool
  default     = true
}

variable "validation_method" {
  description = "Which method to use for validation. DNS or EMAIL are valid, NONE can be used for certificates that were imported into ACM and then into Terraform."
  type        = string
  default     = "DNS"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "create_wildcard" {
  description = "A boolean to enable wildcard cert creation"
  type        = bool
  default     = false
}