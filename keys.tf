# Generate an SSH key pair.
# IMPORTANT: The private key is still stored in Terraform state because
# tls_private_key.private_key_openssh is used by the Secrets Manager resource.
resource "tls_private_key" "datacenter_kp" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Upload only the public key to EC2.
resource "aws_key_pair" "datacenter_kpair" {
  key_name   = "datacenter-kp"
  public_key = tls_private_key.datacenter_kp.public_key_openssh

  tags = {
    Name = "datacenter-kp"
  }
}

# Store both keys in AWS Secrets Manager.
resource "aws_secretsmanager_secret" "datacenter_keys" {
  name = "datacenter-kp"

  tags = {
    Name = "datacenter-kp"
  }
}

resource "aws_secretsmanager_secret_version" "datacenter_keys_version" {
  secret_id = aws_secretsmanager_secret.datacenter_keys.id

  secret_string = jsonencode({
    private_key = tls_private_key.datacenter_kp.private_key_openssh
    public_key  = tls_private_key.datacenter_kp.public_key_openssh
  })
}
