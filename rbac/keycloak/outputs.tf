output "keycloak_ip" {
  value = aws_instance.keycloak.public_ip
}
