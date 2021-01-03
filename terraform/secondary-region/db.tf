data "aws_db_instance" "udacity" {
  provider               = aws.primary
  db_instance_identifier = "udacity"
}

resource "aws_db_subnet_group" "secondary_db_subnet_group" {
  name       = "secondary-db-subnet-group"
  subnet_ids = [aws_subnet.secondary_public_subnet_1.id, aws_subnet.secondary_public_subnet_2.id]

  description = "Secondary DB Subnet Group"

  tags = {
    Name = "Secondary DB Subnet Group"
  }
}

resource "aws_db_instance" "udacity_db_replica" {
  allocated_storage = 20
  storage_type      = "gp2"

  engine = "mysql"

  # Removing the replicate_source_db attribute from an existing RDS Replicate database managed by Terraform will promote the database to a fully standalone database.
  # Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
  replicate_source_db = data.aws_db_instance.udacity.db_instance_arn

  instance_class      = "db.t2.micro"
  name                = "udacity-replica"
  identifier          = "udacity-replica"
  username            = "secretpass"
  password            = "secretpass"
  skip_final_snapshot = true

  db_subnet_group_name = aws_db_subnet_group.secondary_db_subnet_group.name

  vpc_security_group_ids = [aws_security_group.secondary_db_security_group.id]
}

