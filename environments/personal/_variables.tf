variable "territory" {
  description = "Territory"
  type        = string
}

variable "region" {
  description = "Region"
  type        = string
}

variable "aws_region" {
  description = "The aws region for creating the resources in"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR of the vpc"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the public and private hosted zone"
  type        = string
}

variable "default_public_key" {
  description = "The public key that will be used for login into the created ec2 instances"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDEQ9M2aO4bprEjDm1GNhja+EAagIxlRAoIDEjAAp71Ti50/FcjQpyo6PCbFKLX9XhbIE3RHG1czy62YBIqw8WOdUQOAa4bFk50KYfBeyofOrlauDGrujlRGimljwCQw4hhy0lk63wdqVijYXctObKz8tpm5QHly2gj3m8u9/60bmeLiutXVYEybTeb0kdGVLxa+tlhvCH26IbIsqqvqfm8naF+fIEK2zCKwI6zaqczMZ4ExwKtCDPyGgfdKg5wcCagKXj9scGsJWBck20jUyeNSX16f2GCn4r9TNqLn3eAlGz/xCBxx43vKd1NTLKPTpqNKo2ebnnUYNNJFg/J89UQNBNQdcg3nxrypwzQiMxWRSV1UtU2LO3a+KMIfhrZJ3iKFlWpPV943w3WDHokkcrmZbTthbsh9h3RHOnzIGh/96oTtjr3ZhuDwgVmL7N/AVUtuWy1TgAmkGO7ce8Olm7qGkMgJ7OBjrt3/LLbM7sIGIjJQUDuKtX8E8RJRoYtfI0="
}

## Bastion EC2 
variable "bastion_ami" {
  description = "The AMI of the bastion instance"
  type        = string
  default     = ""
}

variable "bastion_name" {
  description = "The name of the bastion instance"
  type        = string
  default     = "bastion"
}

variable "bastion_instancetype" {
  description = "The instance type for use in the bastion host(s)"
  type        = string
  default     = "t3.micro"
}

variable "bastion_count" {
  description = "The number of bastion instances to create"
  type        = number
  default     = 1
}

variable "bastion_root_volume" {
  description = "The root volume configuration for the bastion host(s)"
  type        = list(map(string))
  default     = [{
    "volume_size" = 20,
    "volume_type" = "gp2"
  }]
}

variable "bastion_disable_api_termination" {
  description = "Controls the EC2 Instance Termination Protection"
  type        = bool
  default     = false
}

## Docker EC2
variable "docker_host_name" {
  description = "The name of the docker host instance"
  type        = string
  default     = "docker"
}

variable "docker_host_instancetype" {
  description = "The type of ec2 instance for the docker host node"
  type        = string
  default     = "t3.micro"
}

variable "docker_host_count" {
  description = "The number of docker host instances to be created"
  type        = number
  default     = 0
}

variable "docker_host_root_volume" {
  description = "The root volume configuration for the docker host host(s)"
  type        = list(map(string))
  default     = [{volume_size = 40}]
}

variable "docker_host_disable_api_termination" {
  description = "Controls the EC2 Instance Termination Protection"
  type        = bool
  default     = false
}

## ACM
variable "acm_create_certificate" {
  description = "The boolean to enable ACM Certificate creation"
  type        = bool
  default     = true
}

variable "acm_certificate_arn"  {
  description = "The ARN of the certificate created in ACM"
  type        = string
  default     = ""
}

variable "acm_create_wildcard" {
  description = "To enable creation of wildcard ACM cert"
  type        = bool
  default     = true
}

variable "acm_validate_certificate" {
  description = "To enable creation of wildcard ACM cert"
  type        = bool
  default     = true
}

## OpenVPN EC2 
variable "openvpn_ami" {
  description = "The AMI of the openvpn instance"
  type        = string
  default     = ""
}

variable "openvpn_name" {
  description = "The name of the openvpn instance"
  type        = string
  default     = "openvpn"
}

variable "openvpn_instancetype" {
  description = "The instance type for use in the openvpn host(s)"
  type        = string
  default     = "t3.micro"
}

variable "openvpn_count" {
  description = "The number of openvpn instances to create"
  type        = number
  default     = 0
}

variable "openvpn_root_volume" {
  description = "The root volume configuration for the openvpn host(s)"
  type        = list(map(string))
  default     = [{
    "volume_size" = 20,
    "volume_type" = "gp2"
  }]
}

variable "openvpn_disable_api_termination" {
  description = "Controls the EC2 Instance Termination Protection"
  type        = bool
  default     = false
}

variable "monitoring_host_ami" {
  description = "The AMI of the monitoring instance"
  type        = string
  default     = ""
}

variable "monitoring_host_name" {
  description = "The name of the monitoring instance"
  type        = string
  default     = "monitoring"
}

variable "monitoring_host_instancetype" {
  description = "The instance type for use in the monitoring host(s)"
  type        = string
  default     = "c5.large"
}

variable "monitoring_host_count" {
  description = "The number of monitoring instances to create"
  type        = number
  default     = 0
}

variable "monitoring_host_root_volume" {
  description = "The root volume configuration for the monitoring host(s)"
  type        = list(map(string))
  default     = [{"volume_size" = 20}]
}

variable "monitoring_host_disable_api_termination" {
  description = "Controls the EC2 Instance Termination Protection"
  type        = bool
  default     = true
}

variable "monitoring_host_host_sg_marid_cidr_blocks" {
  description = "Controls if 8443 is opened for legacy Marid integration. Default is meant to be unused - nothing is running on this port by default but due to TF limitations an IP must be specified."
  type        = string
  default     = "127.0.0.1/32"
}


# Docker ALB
variable "docker_host_alb_listener_port" {
  type    = string
  default = "443"
}

variable "docker_host_alb_listener_protocol" {
  type    = string
  default = "HTTPS"
}

variable "docker_host_alb_target_type" {
  description = "The type of target type to use for LB target groups"
  type        = string
  default     = "instance"
}

variable "docker_host_alb_create" {
  type    = bool
  default = false
}

variable "add_root_dns" {
  type    = bool
  default = false
  description = "To add a NS entry to a root R53 zone"
}

variable "root_route53_zone" {
  description = "Root Route53 Zone"
  type        = string
  default     = ""
}