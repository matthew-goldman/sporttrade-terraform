variable "hosted_zone_id" {
  description = "The hosted zone id for creating the records in"
  type        = string
  default     = ""
}

variable "record_name" {
  description = "The name of the record"
  type        = string
  default     = ""
}

variable "records" {
  description = "The record values to create"
  type        = list
}

variable "record_type" {
  description = "The record type. Valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT"
  type        = string
  default     = "A"
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

variable "no_count" {
  description = "Forgo the count in the record name, e.g. foo instead of foo-01"
  type        = bool
  default     = false
}