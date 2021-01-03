#########################
#     PRIMARY REGION    #
#########################

resource "aws_security_group" "primary_app_security_group" {
  name = "UDARR-Application"

  description = "Udacity ARR Project - Application Security Group"
  vpc_id      = aws_vpc.primary_vpc.id

  ingress {
    description = "SSH from the Internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "UDARR-Application"
  }
}

resource "aws_security_group" "primary_db_security_group" {
  name = "UDARR-Database"

  description = "Udacity ARR Project - Database Security Group"
  vpc_id      = aws_vpc.primary_vpc.id

  ingress {
    description     = "Application EC2 instances"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.primary_app_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "UDARR-Database"
  }
}
