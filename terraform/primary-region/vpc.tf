resource "aws_vpc" "primary_vpc" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Primary"
  }
}
