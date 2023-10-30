resource "aws_instance" "web" {
  subnet_id     = var.subnet_id
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}

resource "aws_network_interface" "test" {
  subnet_id = var.subnet_id

  attachment {
    instance     = aws_instance.web.id
    device_index = 1
  }
}

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

  owners = ["amazon"]
}
