variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud folder ID"
  type        = string
}

variable "zone" {
  description = "Availability zone for Vault VM and subnet"
  type        = string
  default     = "ru-central1-a"
}

variable "vm_name" {
  description = "Name of the Vault compute instance"
  type        = string
  default     = "vault-vm"
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "vault-network"
}

variable "subnet_cidr" {
  description = "CIDR block for the Vault subnet"
  type        = string
  default     = "10.10.0.0/24"
}

variable "cores" {
  description = "Number of CPU cores for the Vault VM"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Amount of memory (GB) for the Vault VM"
  type        = number
  default     = 2
}

variable "disk_size" {
  description = "Boot disk size in GB"
  type        = number
  default     = 10
}

variable "image_family" {
  description = "Image family for the Vault VM"
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "ssh_user" {
  description = "SSH user for the Vault VM"
  type        = string
  default     = "ubuntu"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key file"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "allowed_ssh_cidr" {
  description = "CIDR blocks allowed to connect to SSH (port 22)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "allowed_vault_cidr" {
  description = "CIDR blocks allowed to connect to Vault API (port 8200)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
