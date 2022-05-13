territory   = "tfdemo"
region      = "us"
aws_region  = "us-east-1"
vpc_cidr    = "10.0.0.0/16"
domain_name = "tfdemo.libertybelljerseys.com"

add_root_dns      = true
root_route53_zone = "Z061719335387LCWR7PLP"

acm_create_certificate = true
acm_create_wildcard    = true

docker_host_count        = 1
docker_host_root_volume  = [{volume_size = 20}]
