# modules/lambda_rotation/variables.tf
variable "secret_arn" {
  description = "The ARN of the Secrets Manager secret for the password."
  type        = string
}
