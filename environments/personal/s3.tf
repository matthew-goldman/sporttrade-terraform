module "log_bucket" {
    source         = "trussworks/logs/aws"
    version        = "~> 13.0.0"
    s3_bucket_name = "${lower(local.environment)}-${var.territory}-logs"
    default_allow  = false
    allow_alb      = true

    alb_logs_prefixes = ["alb/docker"]

    s3_log_bucket_retention = 1
}