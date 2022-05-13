variable "hosted_zone_id" {
  description = "The hosted zone id for creating the records in"
  type        = string
  default     = ""
}

variable "record_name" {
  description = "The names of the records"
  type        = list(string)
  default     = []
}

variable "record" {
  description = "The record value to create"
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

variable "target_zone_id" {
  description = "Target Zone ID for Alias record"
  type        = string
}