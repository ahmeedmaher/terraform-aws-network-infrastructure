output "vpc_id" {
  value = aws_vpc.testVpc.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.publicsubnet1.id,
    aws_subnet.publicsubnet2.id
  ]
}

output "private_subnet_ids" {
  value = [
    aws_subnet.privatesubnet1.id,
    aws_subnet.privatesubnet2.id
  ]
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}

output "public_instance_ids" {
  value = [
    aws_instance.ec1p.id,
    aws_instance.ec2p2.id
  ]
}

output "private_instance_ids" {
  value = [
    aws_instance.ec2pr1.id,
    aws_instance.ec2pr2.id
  ]
}

output "secret_arn" {
  value = aws_secretsmanager_secret.datacenter_keys.arn
}
