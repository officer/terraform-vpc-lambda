locals {
  iam_role_provided = "${var.role_arn != "none" ? true : false}"
}

resource "aws_lambda_function" "lambda_function" {
  function_name     = "${var.namespace}-generaldump"
  handler           = "${var.handler_name}"
  filename          = "${data.archive_file.function_code.output_path}"
  role              = "${local.iam_role_provided ? var.role_arn : aws_iam_role.default.0.arn}"

  source_code_hash  = "${data.archive_file.function_code.output_base64sha256}"
  runtime           = "${var.runtime}"

  vpc_config {
    subnet_ids          = "${var.subnet_ids}"
    security_group_ids  = "${var.security_group_ids}"
  }


  memory_size       = "${var.memory}"
  timeout           = "${var.timeout}"
  tags              = "${var.tags}"
}


# If no IAM role ARN provided, then create default IAM Role
resource "aws_iam_role" "default" {
  count               = "${local.iam_role_provided ? 0 : 1}"
  name_prefix         = "${var.namespace}"
  assume_role_policy  = "${data.aws_iam_policy_document.assume_role_policy_lambda.json}"
}

resource "aws_iam_role_policy" "default" {
  count               = "${local.iam_role_provided ? 0 : 1}"
  name_prefix         = "${var.namespace}"
  policy              = "${data.aws_iam_policy_document.basic_lambda_policy.json}"
  role                = "${aws_iam_role.default.0.id}"

  depends_on          = ["aws_iam_role.default"]
}


# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "lambda" {
  name                = "/aws/lambda/${aws_lambda_function.lambda_function.function_name}"
  retention_in_days   = 90
  tags                = "${var.tags}"
  depends_on          = ["aws_iam_role.default"]
}
