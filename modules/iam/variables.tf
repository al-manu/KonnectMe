# modules/iam/variables.tf
variable "lambda_role_name" {
  description = "The name of the Lambda execution role."
  type        = string
}
