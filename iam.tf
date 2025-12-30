########################################
# IAM Policy – Allow Bastion to Read Parameter Store
########################################

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "ssm_read_only" {
  statement {
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath"
    ]

    resources = [
      "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.current.account_id}:parameter/${var.project_name}/dev/*"
    ]
  }
}

resource "aws_iam_policy" "ssm_read_only" {
  name   = "${var.project_name}-ssm-read-only"
  policy = data.aws_iam_policy_document.ssm_read_only.json
}

resource "aws_iam_role_policy_attachment" "bastion_ssm_attach" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = aws_iam_policy.ssm_read_only.arn
}
