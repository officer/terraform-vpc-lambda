# Overview
Basic lambda function with VPC that just output event and context as json string.

# Parameters
## subnet_ids
(Required) Subnet ids which will be used by Lambda

## security_group_ids
(Required) Security Group ids which will be used by Lambda

## namespace
Namespace of the resource.

This will be used for the prefix of function name.

## tags
AWS Tags for resources.


## handler_name
Function handler name.


## runtime
Lambda runtime

## role_arn
Function IAM Role ARN