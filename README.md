# nginx-proxy-manager-proxmox

### Requirements:
- Terraform

## Provision LXC container
Create terraform.tfvars then run commands below.
```
terraform init
terraform apply
```

## Install nginx proxy manager
Run command below in the created LXC container's console.
```
sh -c "$(wget --no-cache -qO- https://raw.githubusercontent.com/ej52/proxmox/main/install.sh)" -s --app nginx-proxy-manager
```

### Log into nginx proxy manager page 
Enter the provided IP address in a browser and use the default login:

> E-Mail: admin@example.com
Password: changeme

You may change default email and password.

> :memo: **Note:** Install script only works with Alpine 3.16

### References
https://github.com/angelopaolosantos/proxmox-scripts
http://download.proxmox.com/images/system/
[Local SSL certificates for your homelab](https://youtu.be/qlcVx-k-02E?si=ilEu9mWd9zY0TXas)