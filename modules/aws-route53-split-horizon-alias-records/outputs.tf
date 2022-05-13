output "public_alias_name" {
  description = "The domain name of the record"
  value       = var.record_count != 0 ? aws_route53_record.public_record.0.name : ""
}