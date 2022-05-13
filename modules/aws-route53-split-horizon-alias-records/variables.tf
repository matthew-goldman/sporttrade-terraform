variable "private_hosted_zone_id" {
  description = "The private hosted zone id for creating the records in"
  type        = string
  default     = ""
}

variable "public_hosted_zone_id" {
  description = "The private hosted zone id for creating the records in"
  type        = string
  default     = ""
}

variable "record_name" {
  description = "The name of the record"
  type        = string
  default     = ""
}

variable "private_alias_target" {
  description = "The value to be used in the private hosted zone"
  type        = string
}

variable "private_alias_zone" {
  description = "The zone ID of the private alias target"
  type        = string
}

variable "public_alias_target" {
  description = "The value to be used in the public hosted zone"
  type        = string
}

variable "public_alias_zone" {
  description = "The zone ID of the public alias target"
  type        = string
}

variable "record_type" {
  description = "The record type. Valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT"
  type        = string
  default     = "A"
}

variable "record_allow_overwrite" {
  description = "Allow creation of this record in Terraform to overwrite an existing record, if any."
  type        = bool
  default     = true
}

variable "record_count" {
  description = "The amount of records to create. This tipically matches with the amount of instances you are gonna create records for"
  type        = number
}
