data "archive_file" "function_code" {
  type        = "zip"
  source_dir  = "${var.source_code_path}"
  output_path = "${var.archive_path}"
}


# Lambda AssumeRole
data "aws_iam_policy_document" "assume_role_policy_lambda" {
  statement {
      actions = ["sts:AssumeRole"]
      principals {
          type = "Service"
          identifiers = ["lambda.amazonaws.com"]
      }
      
  }
}

data "aws_iam_policy_document" "basic_lambda_policy" {
  statement {
    actions = [
        "logs:CreateLogGroup"
      ]
      effect = "Allow"
      resources = ["*"]
  }
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    effect = "Allow"
    resources = ["*"]
  }
}
