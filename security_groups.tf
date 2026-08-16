# Security Group for public EC2 instances
resource "aws_security_group" "public" {
  name        = "terraform-public-sg"
  description = "Security group for public EC2 instances"
  vpc_id      = aws_vpc.testVpc.id

  ingress {
    description = "SSH"
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
    Name = "public-sg"
  }
}


# Security Group for private EC2 instances
resource "aws_security_group" "private" {
  name        = "terraform-private-sg"
  description = "Security group for private EC2 instances"
  vpc_id      = aws_vpc.testVpc.id

  # Allow SSH only from instances that use the public SG
  ingress {
    description     = "SSH from public instances"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-sg"
  }
}
