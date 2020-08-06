resource "aws_key_pair" "ssh-key" {
  key_name_prefix = "keycloak"
  public_key      = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "keycloak" {
  ami                         = data.aws_ami.ubuntu.id
  vpc_security_group_ids      = [aws_security_group.allow_keycloak.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh-key.key_name
  instance_type               = "t3.micro"
  user_data                   = file("${path.root}/user_data.sh")

  provisioner "remote-exec" {
    script = "${path.root}/user_data.sh"
    connection {
      type = "ssh"
      user = "ubuntu"
      host = self.public_ip
    }
  }

}

# TOKEN=$(http -f --verify=no POST 'https://localhost:8443/auth/realms/master/protocol/openid-connect/token' username=admin password=admin grant_type=password client_id=admin-cli | jq -r '.access_token')
# http --verify=no POST 'https://localhost:8443/auth/admin/realms/master/clients' "Authorization: bearer $TOKEN"  id=kubernetes-cluster protocol=openid-connect
