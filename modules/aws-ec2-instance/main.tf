locals {
  is_t_instance_type = replace(var.instance_type, "/^t[23]{1}\\..*$/", "1") == "1" ? true : false
  drive_letters = ["b", "c", "d", "e", "f", "g", "h", "i", "j", "k"]
}

######
# Note: network_interface can't be specified together with associate_public_ip_address
######
resource "aws_instance" "this" {
  count                                = var.instance_count
  ami                                  = var.ami
  instance_type                        = var.instance_type
  user_data                            = var.user_data
  subnet_id                            = element(distinct(compact(concat([var.subnet_id], var.subnet_ids))),count.index,)
  key_name                             = var.key_name
  monitoring                           = var.monitoring
  get_password_data                    = var.get_password_data
  vpc_security_group_ids               = var.security_groups
  iam_instance_profile                 = var.iam_instance_profile
  associate_public_ip_address          = var.associate_public_eip || var.associate_public_ip ? true : false
  source_dest_check                    = var.source_dest_check
  disable_api_termination              = var.disable_api_termination
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  placement_group                      = var.placement_group
  tenancy                              = var.tenancy

  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", "gp2")
    }
  }

  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = ebs_block_device.value.device_name
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", "gp2")
    }
  }

  dynamic "ephemeral_block_device" {
    for_each = var.ephemeral_block_device
    content {
      device_name  = ephemeral_block_device.value.device_name
      no_device    = lookup(ephemeral_block_device.value, "no_device", null)
      virtual_name = lookup(ephemeral_block_device.value, "virtual_name", null)
    }
  }

  tags = merge(
    {
      Name = var.instance_count > 1 || var.use_num_suffix ? format("%s-%s-%s-%02d", var.tags["Environment"], var.tags["Territory"], var.name, count.index + 1) : var.name
      Fqdn = "${var.dns_domain == "" ? "" : var.instance_count > 1 || var.use_num_suffix ? format("%s-%02d.", var.name, count.index + 1) : var.name}${var.dns_domain}"
    },
    var.tags, {"Role"=var.name},
  )

  volume_tags = merge(
    {
      Name = var.instance_count > 1 || var.use_num_suffix ? format("%s-%s-%s-%02d", var.tags["Environment"], var.tags["Territory"], var.name, count.index + 1) : var.name
    },
    var.volume_tags, var.tags,
  )

  credit_specification {
    cpu_credits = local.is_t_instance_type ? var.cpu_credits : null
  }

  lifecycle {
    # Due to several known issues in Terraform AWS provider related to arguments of aws_instance:
    # (eg, https://github.com/terraform-providers/terraform-provider-aws/issues/2036)
    # we have to ignore changes in the following arguments
    ignore_changes = [
      root_block_device,
      ebs_block_device,
      ebs_optimized,
      ami,
      key_name
    ]
  }

}

resource "aws_eip" "eip" {
  count      = var.associate_public_eip && var.instance_count > 0 ? var.instance_count : 0
  vpc        = true
  instance   = aws_instance.this.*.id[count.index]
  tags = merge(
    var.tags,
    { Name = var.instance_count > 1 || var.use_num_suffix ? format("%s-%s-%s-%02d-eip", var.tags["Environment"], var.tags["Territory"], var.name, count.index + 1) : var.name }
  )
}



resource "aws_ebs_volume" "external_ebs_volumes" {
  count                 = lookup(var.external_ebs, "count", 0) * var.instance_count
  availability_zone     = lookup(var.external_ebs, "count") > 0 ? element(concat(aws_instance.this.*.availability_zone), count.index) : null
  encrypted             = lookup(var.external_ebs, "encrypted", false)
  iops                  = lookup(var.external_ebs, "iops", null)
  snapshot_id           = lookup(var.external_ebs, "snapshot_id", null)
  size                  = lookup(var.external_ebs, "volume_size", null)
  type                  = lookup(var.external_ebs, "volume_type", null)
  lifecycle {
    ignore_changes = [ availability_zone ]
  }
  tags = merge(
    { Name = format("%s-%s-%s-%02d", var.tags["Environment"], var.tags["Territory"], var.name, count.index + 1) },
    var.tags
  )
}

resource "aws_volume_attachment" "external_ebs_volume" {
  device_name = format("/dev/xvd%s", element(local.drive_letters, count.index))
  volume_id   = element(aws_ebs_volume.external_ebs_volumes.*.id, count.index)
  instance_id = element(concat(aws_instance.this.*.id), count.index)
  count       = lookup(var.external_ebs, "count", 0) * var.instance_count
}
