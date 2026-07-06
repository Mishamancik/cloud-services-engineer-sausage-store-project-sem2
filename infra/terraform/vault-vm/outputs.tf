output "vault_public_ip" {
  description = "Public IP address of the Vault VM (use as global.vault.host in Helm values)"
  value       = yandex_compute_instance.vault.network_interface[0].nat_ip_address
}

output "vault_private_ip" {
  description = "Private IP address of the Vault VM inside the VPC"
  value       = yandex_compute_instance.vault.network_interface[0].ip_address
}

output "vault_instance_id" {
  description = "Yandex Cloud compute instance ID"
  value       = yandex_compute_instance.vault.id
}

output "vault_ssh_command" {
  description = "Example SSH command to connect to the Vault VM"
  value       = "ssh ${var.ssh_user}@${yandex_compute_instance.vault.network_interface[0].nat_ip_address}"
}
