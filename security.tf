# Security group: allow SSH only from your IP
resource "aws_security_group" "allow_ssh" {
  name        = "${var.project_name}-ssh"
  description = "Allow SSH from admin IP"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from admin IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-ssh-sg"
    Project     = var.project_name
    Environment = "dev"
  }
}

# Security group: allow all traffic inside the VPC (for app ↔ AWX, etc.)
resource "aws_security_group" "allow_internal" {
  name        = "${var.project_name}-internal"
  description = "Allow all traffic within the VPC CIDR"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-internal-sg"
    Project     = var.project_name
    Environment = "dev"
  }
}
