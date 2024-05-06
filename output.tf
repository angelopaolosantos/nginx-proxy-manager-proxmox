output "alpine_container_password" {
  value     = random_password.alpine_container_password.result
  sensitive = true
}

output "alpine_private_key" {
  value     = tls_private_key.alpine_private_key.private_key_pem
  sensitive = true
}

output "alpine_public_key" {
  value = tls_private_key.alpine_private_key.public_key_openssh
}
