data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "ssh-key" {
  key_name_prefix   = "keycloak"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "keycloak" {
  ami           = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  key_name = aws_key_pair.ssh-key.key_name
  instance_type = "t3.micro"

  user_data = file("${path.root}/user_data.sh")
}
