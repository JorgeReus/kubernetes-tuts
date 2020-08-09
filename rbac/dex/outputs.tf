output "keycloak_url" {
  value = "https://${aws_route53_record.www.fqdn}:8443"
}

output "instance_ip" {
  value = "ubuntu@${aws_instance.keycloak.public_ip}"
}

