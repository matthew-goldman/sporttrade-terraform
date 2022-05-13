output "aws_lb_arn" {
  description = "The arn of the LB"
  value       = aws_lb.main.arn
}

output "aws_lb_dns" {
  description = "The DNS name of the LB"
  value       = aws_lb.main.dns_name
}

output "aws_lb_zone_id" {
  description = "The Zone ID of the LB"
  value       = aws_lb.main.zone_id
}