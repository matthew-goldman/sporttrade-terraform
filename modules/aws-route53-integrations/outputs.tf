output "fqdns" {
  description = "List of Public FQDNs"
  value       = [aws_route53_record.record.*.name]
}


output "ips" {
  description = "List of IPs"
  value       = [aws_route53_record.record.*.records]
}
