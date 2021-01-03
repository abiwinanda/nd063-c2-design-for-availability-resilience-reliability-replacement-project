resource "aws_db_subnet_group" "primary_db_subnet_group" {
  name       = "primary-db-subnet-group"
  subnet_ids = [aws_subnet.primary_public_subnet_1.id, aws_subnet.primary_public_subnet_2.id]

  description = "Primary DB Subnet Group"

  tags = {
    Name = "Primary DB Subnet Group"
  }
}

resource "aws_db_subnet_group" "secondary_db_subnet_group" {
  provider = aws.secondary

  name       = "secondary-db-subnet-group"
  subnet_ids = [aws_subnet.secondary_public_subnet_1.id, aws_subnet.secondary_public_subnet_2.id]

  description = "Secondary DB Subnet Group"

  tags = {
    Name = "Secondary DB Subnet Group"
  }
}
