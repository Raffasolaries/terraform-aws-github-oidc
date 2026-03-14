# terraform-aws-github-oidc

Terraform configuration to set up OpenID Connect (OIDC) federation between GitHub Actions and AWS. This eliminates the need for long-lived AWS credentials in GitHub repositories.

## What it creates

| Resource | Description |
|----------|-------------|
| `aws_iam_openid_connect_provider` | GitHub Actions OIDC provider in AWS IAM |
| `aws_iam_role` | IAM role assumable by GitHub Actions workflows |
| `aws_iam_role_policy_attachment` | Managed policy attachments on the role |

## Trust policy

The IAM role trust policy is scoped to:

- **Audience**: `sts.amazonaws.com` (required by `aws-actions/configure-aws-credentials`)
- **Subject**: `repo:Raffasolaries/*` — only repos under the [Raffasolaries](https://github.com/Raffasolaries) GitHub user can assume this role

## Usage in GitHub Actions

```yaml
permissions:
  id-token: write
  contents: read

steps:
  - uses: aws-actions/configure-aws-credentials@v4
    with:
      role-to-assume: arn:aws:iam::480391725083:role/github-actions-oidc
      aws-region: eu-west-1

  - run: aws sts get-caller-identity
```

## Configuration

Copy `terraform.tfvars.example` to `terraform.tfvars` and adjust as needed:

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
terraform apply
```

## Variables

| Name | Description | Default |
|------|-------------|---------|
| `aws_region` | AWS region | `eu-west-1` |
| `aws_profile` | AWS CLI profile | `iamadmin` |
| `github_owner` | GitHub user/org scoped in trust policy | `Raffasolaries` |
| `iam_role_name` | Name of the IAM role | `github-actions-oidc` |
| `iam_role_max_session_duration` | Max session duration (seconds) | `3600` |
| `iam_policy_arns` | Managed policy ARNs to attach | `[AdministratorAccess]` |

## Outputs

| Name | Description |
|------|-------------|
| `oidc_provider_arn` | ARN of the GitHub OIDC provider |
| `iam_role_arn` | ARN of the IAM role for GitHub Actions |
| `iam_role_name` | Name of the IAM role |

## Requirements

- Terraform >= 1.5
- AWS Provider ~> 6.0
- TLS Provider ~> 4.2
