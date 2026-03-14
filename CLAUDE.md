# CLAUDE.md — terraform-aws-github-oidc

## Project Overview

Terraform configuration for GitHub Actions OIDC federation with AWS account `480391725083`. Allows any repo under [Raffasolaries](https://github.com/Raffasolaries) to assume an IAM role without static credentials.

## Key Details

- **OIDC Provider**: `token.actions.githubusercontent.com`
- **IAM Role**: `github-actions-oidc` (AdministratorAccess)
- **Trust scope**: `repo:Raffasolaries/*` only
- **State**: Local (committed to git)
- **Providers**: AWS ~> 6.0, TLS ~> 4.2

## Commands

```bash
terraform init
terraform plan
terraform apply
```

## Structure

```
├── versions.tf              # Terraform + provider version constraints
├── provider.tf              # AWS provider config
├── variables.tf             # Input variables
├── main.tf                  # OIDC provider + IAM role + policy attachments
├── outputs.tf               # Role ARN, OIDC provider ARN
├── terraform.tfvars.example # Example variable values
├── terraform.tfstate        # Local state (committed)
└── .terraform.lock.hcl      # Provider lock file
```

## Conventions

- State is stored locally in git (small project, no secrets in state)
- No hardcoded profile in providers for portability
- Thumbprint fetched dynamically via `tls_certificate` data source
