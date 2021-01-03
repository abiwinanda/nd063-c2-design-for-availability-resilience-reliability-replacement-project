resource "aws_db_subnet_group" "primary_db_subnet_group" {
  name       = "primary-db-subnet-group"
  subnet_ids = [aws_subnet.primary_public_subnet_1.id, aws_subnet.primary_public_subnet_2.id]

  description = "Primary DB Subnet Group"

  tags = {
    Name = "Primary DB Subnet Group"
  }
}

resource "aws_db_instance" "udacity_db" {
  allocated_storage = 20
  storage_type      = "gp2"

  engine = "mysql"

  instance_class      = "db.t2.micro"
  name                = "udacity"
  identifier          = "udacity"
  username            = "secretpass"
  password            = "secretpass"
  skip_final_snapshot = true

  # Required to be > 0 since used as a source of a read replica
  backup_retention_period = 10
  backup_window           = "23:00-23:59"

  db_subnet_group_name = aws_db_subnet_group.primary_db_subnet_group.name

  vpc_security_group_ids = [aws_security_group.primary_db_security_group.id]
}
