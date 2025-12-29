resource "aws_instance" "awx" {
  ami           = var.awx_ami
  instance_type = "t3.medium"

  subnet_id = aws_subnet.private_a.id

  vpc_security_group_ids = [
    aws_security_group.allow_internal.id,
    aws_security_group.allow_ssh.id
  ]

  associate_public_ip_address = false

  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name

  tags = {
    Name        = "${var.project_name}-awx"
    Project     = var.project_name
    Environment = "dev"
  }
}

# IAM role so EC2 can use SSM (no SSH keys needed)
resource "aws_iam_role" "ssm_role" {
  name = "${var.project_name}-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "${var.project_name}-ssm-profile"
  role = aws_iam_role.ssm_role.name
}
