resource "aws_key_pair" "ssh-key" {
  key_name_prefix = "dex"
  public_key      = file("~/.ssh/id_rsa.pub")
}

resource "aws_route53_zone" "primary" {
  name = "zone_name"
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "domain_name"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.keycloak.public_ip]
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
