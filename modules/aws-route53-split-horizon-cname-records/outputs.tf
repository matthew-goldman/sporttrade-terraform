output "public_fqdns" {
  description = "List of Public FQDNs"
  value       = [aws_route53_record.public_record.*.name]
}

output "private_fqdns" {
  description = "List of Private FQDNs"
  value       = [aws_route53_record.private_record.*.name]
}

output "private_ips" {
  description = "List of Private IPs"
  value       = [aws_route53_record.private_record.*.records]
}

output "public_ips" {
  description = "List of Public IPs"
  value       = [aws_route53_record.public_record.*.records]
}
