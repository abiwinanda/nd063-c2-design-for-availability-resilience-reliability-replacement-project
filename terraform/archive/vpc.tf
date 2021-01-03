# Primary vpc. Located in ap-southeast-1
resource "aws_vpc" "primary_vpc" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Primary"
  }
}

# Secondary vpc. Located in ap-southeast-2
resource "aws_vpc" "secondary_vpc" {
  provider         = aws.secondary
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Secondary"
  }
}
