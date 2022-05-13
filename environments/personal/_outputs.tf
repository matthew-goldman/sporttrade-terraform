output "bastion_ip" {
    description = "Public IP of the Bastion host"
    value       = flatten(module.bastion-dns-records.public_ips[0]).0
}
