################################
#        PRIVATE SUBNETS       #
################################

resource "aws_subnet" "primary_private_subnet_1" {
  vpc_id     = aws_vpc.primary_vpc.id
  cidr_block = "10.1.20.0/24"

  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "Primary Private Subnet 1"
  }
}

resource "aws_subnet" "primary_private_subnet_2" {
  vpc_id     = aws_vpc.primary_vpc.id
  cidr_block = "10.1.21.0/24"

  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "Primary Private Subnet 2"
  }
}

###############################
#        PUBLIC SUBNETS       #
###############################

# Public subnets is simply a subnet where its route table has a route to an internet gateway
# hence before public subnet can be created we need to create an intenet gateway.
# Reference: https://medium.com/@kuldeep.rajpurohit/vpc-with-public-and-private-subnet-nat-on-aws-using-terraform-85a18d17c95e

resource "aws_internet_gateway" "primary_ig" {
  # This will attached the internet gateway to the primary vpc
  vpc_id = aws_vpc.primary_vpc.id

  tags = {
    Name = "Primary"
  }
}

# An IG has been created, now lets create a route table that has route to an the internet gateway. Again, IG is required for public subnet.
resource "aws_route_table" "primary_public_rt" {
  depends_on = [
    aws_vpc.primary_vpc,
    aws_internet_gateway.primary_ig,
  ]

  vpc_id = aws_vpc.primary_vpc.id

  # Map 0.0.0.0/0 to the main-gw
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.primary_ig.id
  }

  tags = {
    Name = "Primary Public Routes"
  }
}

# Make the public subnet
resource "aws_subnet" "primary_public_subnet_1" {
  vpc_id                  = aws_vpc.primary_vpc.id
  cidr_block              = "10.1.10.0/24"
  map_public_ip_on_launch = true

  availability_zone = "ap-southeast-1c"

  tags = {
    Name = "Primary Public Subnet 1"
  }
}

resource "aws_subnet" "primary_public_subnet_2" {
  vpc_id                  = aws_vpc.primary_vpc.id
  cidr_block              = "10.1.11.0/24"
  map_public_ip_on_launch = true

  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "Primary Public Subnet 2"
  }
}

# Attach the route table that has route to an interget gateway to the (public) subnets
resource "aws_route_table_association" "primary_public_subnet_1_route_table_association" {
  depends_on = [
    aws_subnet.primary_public_subnet_1,
    aws_route_table.primary_public_rt,
  ]
  subnet_id      = aws_subnet.primary_public_subnet_1.id
  route_table_id = aws_route_table.primary_public_rt.id
}

resource "aws_route_table_association" "primary_public_subnet_2_route_table_association" {
  depends_on = [
    aws_subnet.primary_public_subnet_2,
    aws_route_table.primary_public_rt,
  ]
  subnet_id      = aws_subnet.primary_public_subnet_2.id
  route_table_id = aws_route_table.primary_public_rt.id
}
