variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}
variable "project_name" {
  description = "Short name for this platform (used in tags and resource names)"
  type        = string
  default     = "infra-platform"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the main VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet (NAT gateway lives here)"
  type        = string
  default     = "10.0.0.0/24"
}

variable "private_subnet_a_cidr" {
  description = "CIDR block for private subnet in AZ A"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_b_cidr" {
  description = "CIDR block for private subnet in AZ B"
  type        = string
  default     = "10.0.2.0/24"
}
variable "awx_ami" {
  description = "Base Linux image for AWX host"
  type        = string
}
variable "ssh_allowed_cidr" {
  description = "Admin IP/CIDR allowed to SSH into AWX host"
  type        = string
}