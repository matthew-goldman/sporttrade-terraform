module "docker_host_alb" {
    source                       = "../../modules/aws-alb-docker"
    alb_name                     = "docker-app"
    alb_listener_port            = var.docker_host_alb_listener_port
    alb_listener_protocol        = var.docker_host_alb_listener_protocol
    territory                    = var.territory
    alb_subnet_ids               = module.vpc.public_subnets
    alb_vpc_id                   = module.vpc.vpc_id
    alb_docker_host_target_id    = module.ec2-instance-docker-host.id
    alb_docker_host_target_count = var.docker_host_count
    alb_enable_proxy_protocol_v2 = false
    aws_lb_target_type           = var.docker_host_alb_target_type
    certificate_arn              = module.acm.this_acm_certificate_arn
    security_groups              = [module.docker-alb-sg.id]
    log_bucket_id                = module.log_bucket.aws_logs_bucket
    tags                         = local.standard_tags
}