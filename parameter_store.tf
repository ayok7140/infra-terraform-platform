########################################
# SSM Parameter Store – Application Secrets
########################################

# Store application admin username
resource "aws_ssm_parameter" "app_admin_user" {
  name  = "/${var.project_name}/dev/app_admin_user"
  type  = "String"
  value = var.app_admin_user

  tags = {
    Project     = var.project_name
    Environment = "dev"
  }
}

# Store application admin password (encrypted)
resource "aws_ssm_parameter" "app_admin_password" {
  name   = "/${var.project_name}/dev/app_admin_password"
  type   = "SecureString"
  value  = var.app_admin_password
  key_id = "alias/aws/ssm" # default SSM KMS key – fine for this project

  tags = {
    Project     = var.project_name
    Environment = "dev"
  }
}
