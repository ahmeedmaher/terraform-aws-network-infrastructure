# Terraform AWS VPC

This configuration creates:

- 1 VPC: `10.0.0.0/16`
- 2 public subnets
- 2 private subnets
- 1 Internet Gateway
- 1 Elastic IP
- 1 NAT Gateway
- 1 public route table
- 1 private route table
- 2 public EC2 instances
- 2 private EC2 instances
- Public and private Security Groups
- RSA SSH key pair
- AWS Secrets Manager secret containing the public/private key

## Traffic flow

Public:

Public EC2 -> Public Route Table -> Internet Gateway -> Internet

Private:

Private EC2 -> Private Route Table -> NAT Gateway -> Public Route Table -> Internet Gateway -> Internet

The private instances do not receive public IP addresses.

## Commands

```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

To destroy:

```bash
terraform destroy
```

## Important security note

The private key is referenced by Terraform resources, so it will exist in Terraform state.

Do not commit `terraform.tfstate` or `.terraform/` to Git.

For a real production environment, use a remote encrypted Terraform backend and protect state access carefully.
