variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "aws_profile" {
  description = "AWS CLI profile to use"
  type        = string
  default     = "iamadmin"
}

variable "github_owner" {
  description = "GitHub username or organization. Only repos under this owner can assume the role."
  type        = string
  default     = "Raffasolaries"
}

variable "iam_role_name" {
  description = "Name for the IAM role assumed by GitHub Actions"
  type        = string
  default     = "github-actions-oidc"
}

variable "iam_role_max_session_duration" {
  description = "Maximum session duration in seconds (1h-12h)"
  type        = number
  default     = 3600
}

variable "iam_policy_arns" {
  description = "IAM managed policy ARNs to attach to the GitHub Actions role"
  type        = set(string)
  default     = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}
