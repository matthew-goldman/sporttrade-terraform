output "iam_arn" {
  value = aws_iam_user.this.arn
}

output "iam_name" {
  value = aws_iam_user.this.name
}

output "iam_id" {
  value = aws_iam_user.this.id
}

output "policy_id" {
  value = aws_iam_user_policy.this.id
}

output "policy_name" {
  value = aws_iam_user_policy.this.name
}
