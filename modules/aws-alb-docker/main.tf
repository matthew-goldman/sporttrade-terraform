# Create the ALB
resource "aws_lb" "main" {
  name                             = "${var.alb_name}-${var.territory}-alb"
  load_balancer_type               = "application"
  security_groups                  = var.security_groups
  enable_cross_zone_load_balancing = var.alb_enable_cross_zone_load_balancing
  subnets                          = var.alb_subnet_ids

  access_logs {
    bucket  = var.log_bucket_id
    prefix  = "alb/${var.alb_name}"
    enabled = false
  }

  tags = merge(
    { Name = format("%s-%s-%s-lb", var.tags["Environment"], var.tags["Territory"], var.alb_name) },
    var.tags
  )
}

# Default Port listener
resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.main.arn
  port              = var.alb_listener_port
  protocol          = var.alb_listener_protocol
  certificate_arn   = var.certificate_arn
  default_action {
    target_group_arn = aws_alb_target_group.docker-host.id
    type             = "forward"
  }
}

# Sending to docker-host instance
resource "aws_alb_listener_rule" "docker-host" {
  depends_on   = [aws_alb_target_group.docker-host]
  listener_arn = aws_alb_listener.alb_listener.arn
  priority     = 99
  action {    
    type             = "forward"    
    target_group_arn = aws_alb_target_group.docker-host.id
  }   
  condition {    
    host_header {
       values = ["docker-host.${var.territory}.remote.management"]
    }
  }
}

# docker-host target group
resource "aws_alb_target_group" "docker-host" {
  name         = "docker-host-${var.territory}"
  port         = var.docker_host_port
  protocol     = var.docker_host_protocol
  vpc_id       = var.alb_vpc_id

  tags = merge(
    { Name = format("%s-%s-%s-lb-docker-host-target-group", var.tags["Environment"], var.tags["Territory"], var.alb_name) },
    var.tags
  )
}

# docker-host target group attachment
resource "aws_alb_target_group_attachment" "docker-host" {
  target_group_arn = aws_alb_target_group.docker-host.id
  target_id        = element(var.alb_docker_host_target_id, count.index)
  count            = var.alb_docker_host_target_count
}

