variable "proxmox_endpoint" {
  type = string
  default = "https://my-proxmox-endpoint.local/"
}

variable "proxmox_username" {
  type = string
  default = "root@pam"
}

variable "proxmox_password" {
  type = string
  default = "my-proxmox-password"
}

variable "gateway" {
    type = string
    default = "192.168.254.254"
    description = "network gateway"
}

variable "container_ips" {
    type = string
    default = "192.168.254.158"
}

variable "network_range" {
    type = string
    default = "24"
}

variable "container_user" {
    type = string
    default = "angelo"
}