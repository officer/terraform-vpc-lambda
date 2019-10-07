# VPC Configuration
variable "security_group_ids" {
  description = "(Required) vpc security group ids that used by Lambda"
  type        = "list"
}

variable "subnet_ids" {
  description = "(Required) VPC subnet ids that used by Lambda"
  type        = "list"
}

# General Configuration
variable "namespace" {
  description = "(Optional) namespace of the resources default to lambda"
  type        = "string"
  default     = "lambda"
}

variable "tags" {
  description = "(Optional) tags for resources default CreatedBy=Terraform"
  type        = "map"
  default     = {
    CreatedBy = "Terraform"
  }
}

# function configurations
variable "handler_name" {
  description = "(Optional) handler name if not provided, handler name in default function will be used"
  type = "string"
  default = "main.lambdaHandler"
}

variable "runtime" {
  description = "(Optional) Lambda function's runtime name if not provided, default to nodejs10.x"
  type        = "string"
  default     = "nodejs10.x"
}

variable "timeout" {
  description = "(Optional) Lambda function's timeout second, default to 30"
  type        = number
  default     = 30
}

variable "memory_size" {
  description = "(Optional) Lambda function's memory size, default to 128"
  type        = number
  default     = 128
}

variable "role_arn" {
  description = "(Optional) lambda function role arn. if not provided, basic-lambda-execution role created and used."
  type        = "string"
  default     = "none"
}

variable "source_code_path" {
  description = "(Optional) path to lambda handler source directory. if not provided, default function will be used"
  type        = "string"
  default     = "./terraform-basic-lambda/lambda/source"
}

variable "archive_path" {
  description = "(Optional) path to lambda handler archive directory. if not provided, default function will be used"
  type        = "string"
  default     = "./terraform-basic-lambda/lambda/upload/lambda_function.zip"
}
