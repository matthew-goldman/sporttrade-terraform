# CentOS 8 Stream
data "aws_ami" "centos-8" {
    owners      = ["125523088429"]
    most_recent = true
    filter {
        name   = "name"
        values = ["CentOS Stream 8*"]
    }
    filter {
        name   = "architecture"
        values = ["x86_64"]
    }
    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }
}
