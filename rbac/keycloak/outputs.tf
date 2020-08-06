output "keycloak_url" {
  value = "https://${aws_instance.keycloak.public_ip}:8443"
}
