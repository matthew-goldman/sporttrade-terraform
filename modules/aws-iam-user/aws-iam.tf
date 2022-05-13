resource "aws_iam_user" "this" {
  name = var.user_name
  path = var.path
  permissions_boundary = var.permission_boundary
  force_destroy = var.force_destroy
  tags = var.tags
}

resource "aws_iam_user_policy" "this" {
  name_prefix = var.policy_name
  user        = aws_iam_user.this.name
  policy      = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket"],
      "Resource": ["${var.s3_bucket_arn}"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Resource": ["${var.s3_bucket_arn}/*"]
    }
  ]
}
POLICY
}
