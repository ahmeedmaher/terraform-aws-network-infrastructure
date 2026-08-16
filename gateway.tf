resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.testVpc.id

  tags = {
    Name = "test-igw"
  }
}

resource "aws_eip" "pulicip" {
  domain = "vpc"

  tags = {
    Name = "test-nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.pulicip.id
  subnet_id     = aws_subnet.publicsubnet1.id

  depends_on = [aws_internet_gateway.gw]

  tags = {
    Name = "test-nat-gateway"
  }
}
