# https://registry.terraform.io/modules/terraform-aws-modules/key-pair/aws/latest
resource "tls_private_key" "this" {
  algorithm = "RSA"
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "primary"
  public_key = tls_private_key.this.public_key_openssh
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

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "primary_ec2" {
  depends_on = [aws_subnet.primary_public_subnet_1, module.key_pair]

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  subnet_id = aws_subnet.primary_public_subnet_1.id

  security_groups = [aws_security_group.primary_app_security_group.id]

  key_name = module.key_pair.this_key_pair_key_name

  tags = {
    Name = "Primary EC2"
  }
}
