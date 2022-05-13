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

variable "public_records" {
  description = "The public values to be used in the public hosted zone"
  type        = string
}

variable "private_records" {
  description = "The private values to be used in the private hosted zone"
  type        = string
}

variable "record_type" {
  description = "The record type. Valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT"
  type        = string
  default     = "CNAME"
}

variable "record_ttl" {
  description = "The TTL of the record."
  type        = string
  default     = "300"
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

variable "public_create" {
  description = "Boolean to enable creation of DNS in public zone"
  type        = bool
  default     = false
}