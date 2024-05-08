resource "tls_private_key" "alpine_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096

  provisioner "local-exec" {
    command = "mkdir -p .ssh"
  }

  provisioner "local-exec" { # Copy a "myKey.pem" to local computer.
    command = "echo '${tls_private_key.alpine_private_key.private_key_pem}' | tee ${path.cwd}/.ssh/myKey.pem"
  }

  provisioner "local-exec" {
    command = "chmod 600 ${path.cwd}/.ssh/myKey.pem"
  }
}

resource "proxmox_virtual_environment_container" "alpine_container" {
  description = "Managed by Terraform"
  node_name = "pve01"
  vm_id     = 1234
  tags        = ["terraform", "alpine"]

  initialization {
    hostname = "nginx-proxy-manager"

    ip_config {
      ipv4 {
        address = "${var.container_ip}/${var.network_range}"
        gateway = var.gateway
      }
    }

    user_account {
      keys     = [trimspace(tls_private_key.alpine_private_key.public_key_openssh)]
      # Specify password or use a random generated password
      # password = random_password.alpine_vm_password.result
      password = "mypassword"
    }

  }

  network_interface {
    name = "veth0"
  }

  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.latest_alpine_3_19_default_lxc_img.id
    type             = "alpine"
  }

  disk {
    datastore_id = "local-zfs"
    size = 25
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 512
  }

  startup {
    order      = "3"
    up_delay   = "60"
    down_delay = "60"
  }
}

resource "proxmox_virtual_environment_download_file" "latest_alpine_3_19_default_lxc_img" {
  content_type = "vztmpl"
  datastore_id = "local"
  node_name    = "pve01"
  url          = "http://download.proxmox.com/images/system/alpine-3.16-default_20220622_amd64.tar.xz"
}

resource "random_password" "alpine_container_password" {
  length           = 16
  override_special = "_%@"
  special          = true
}