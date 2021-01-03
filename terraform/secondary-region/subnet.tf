################################
#        PRIVATE SUBNETS       #
################################

resource "aws_subnet" "secondary_private_subnet_1" {
  vpc_id     = aws_vpc.secondary_vpc.id
  cidr_block = "10.1.20.0/24"

  availability_zone = "ap-southeast-2a"

  tags = {
    Name = "Secondary Private Subnet 1"
  }
}

resource "aws_subnet" "secondary_private_subnet_2" {
  vpc_id     = aws_vpc.secondary_vpc.id
  cidr_block = "10.1.21.0/24"

  availability_zone = "ap-southeast-2b"

  tags = {
    Name = "Secondary Private Subnet 2"
  }
}

##########################################
#        PUBLIC SUBNETS (SECONDARY)      #
##########################################

resource "aws_internet_gateway" "secondary_ig" {
  # This will attached the internet gateway to the secondary vpc
  vpc_id = aws_vpc.secondary_vpc.id

  tags = {
    Name = "Secondary"
  }
}

resource "aws_route_table" "secondary_public_rt" {
  depends_on = [
    aws_vpc.secondary_vpc,
    aws_internet_gateway.secondary_ig,
  ]

  vpc_id = aws_vpc.secondary_vpc.id

  # Map 0.0.0.0/0 to the main-gw
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.secondary_ig.id
  }

  tags = {
    Name = "Secondary Public Routes"
  }
}

resource "aws_subnet" "secondary_public_subnet_1" {
  vpc_id                  = aws_vpc.secondary_vpc.id
  cidr_block              = "10.1.10.0/24"
  map_public_ip_on_launch = true

  availability_zone = "ap-southeast-2c"

  tags = {
    Name = "Secondary Public Subnet 1"
  }
}

resource "aws_subnet" "secondary_public_subnet_2" {
  vpc_id                  = aws_vpc.secondary_vpc.id
  cidr_block              = "10.1.11.0/24"
  map_public_ip_on_launch = true

  availability_zone = "ap-southeast-2a"

  tags = {
    Name = "Secondary Public Subnet 2"
  }
}

resource "aws_route_table_association" "secondary_public_subnet_1_route_table_association" {
  depends_on = [
    aws_subnet.secondary_public_subnet_1,
    aws_route_table.secondary_public_rt,
  ]
  subnet_id      = aws_subnet.secondary_public_subnet_1.id
  route_table_id = aws_route_table.secondary_public_rt.id
}

resource "aws_route_table_association" "secondary_public_subnet_2_route_table_association" {
  depends_on = [
    aws_subnet.secondary_public_subnet_2,
    aws_route_table.secondary_public_rt,
  ]
  subnet_id      = aws_subnet.secondary_public_subnet_2.id
  route_table_id = aws_route_table.secondary_public_rt.id
}
