# Amazon Linux 2023 AMI
locals {
  amazon_linux_2023_ami = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

# Public EC2 - 1
resource "aws_instance" "ec1p" {
  ami           = local.amazon_linux_2023_ami
  instance_type = "t3.micro"

  subnet_id              = aws_subnet.publicsubnet1.id
  vpc_security_group_ids = [aws_security_group.public.id]

  associate_public_ip_address = true
  key_name                   = aws_key_pair.datacenter_kpair.key_name

  tags = {
    Name = "public-ec2-1"
  }
}

# Public EC2 - 2
resource "aws_instance" "ec2p2" {
  ami           = local.amazon_linux_2023_ami
  instance_type = "t3.micro"

  subnet_id              = aws_subnet.publicsubnet2.id
  vpc_security_group_ids = [aws_security_group.public.id]

  associate_public_ip_address = true
  key_name                   = aws_key_pair.datacenter_kpair.key_name

  tags = {
    Name = "public-ec2-2"
  }
}

# Private EC2 - 1
resource "aws_instance" "ec2pr1" {
  ami           = local.amazon_linux_2023_ami
  instance_type = "t3.micro"

  subnet_id              = aws_subnet.privatesubnet1.id
  vpc_security_group_ids = [aws_security_group.private.id]

  associate_public_ip_address = false
  key_name                   = aws_key_pair.datacenter_kpair.key_name

  tags = {
    Name = "private-ec2-1"
  }
}

# Private EC2 - 2
resource "aws_instance" "ec2pr2" {
  ami           = local.amazon_linux_2023_ami
  instance_type = "t3.micro"

  subnet_id              = aws_subnet.privatesubnet2.id
  vpc_security_group_ids = [aws_security_group.private.id]

  associate_public_ip_address = false
  key_name                   = aws_key_pair.datacenter_kpair.key_name

  tags = {
    Name = "private-ec2-2"
  }
}
