output "lambda_function_name" {
  description = "Nome da Função Lambda"
  value       = aws_lambda_function.process_files.function_name
}

output "lambda_function_arn" {
  description = "ARN da Função Lambda"
  value       = aws_lambda_function.process_files.arn
}

output "repo_lambda" {
  description = "Nome do repositório"
  value       = "${local.repository}"
}