variable "environment" {
  description = "Nome do Ambiente"
  type        = string
}

locals {
  environment = var.environment
  repository = "ws_terraform_wkl"
  common_tags = {
    Environment = local.environment
    Project     = "ProjectName"
    ManagedBy   = "Terraform"
    Repository = local.repository
  }
}