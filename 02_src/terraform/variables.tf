variable "location" {
  description = "Azure region for the project"
  type        = string
  default     = "Australia East"
}

variable "vm_size" {
  description = "Size of the Azure virtual machine"
  type        = string
  default     = "Standard_B2as_v2"
}

variable "admin_username" {
  description = "Administrator username for the VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key"
  type        = string
  default     = "~/.ssh/elk_vm_key.pub"
}