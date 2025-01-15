output "dynamodb_table_name" {
  description = "Nome da Tabela DynamoDB"
  value       = aws_dynamodb_table.results.name
}

output "dynamodb_table_arn" {
  description = "ARN da Tabela DynamoDB"
  value       = aws_dynamodb_table.results.arn
}

output "repo_dynamodb" {
  description = "Nome do repositório"
  value       = "${local.repository}"
}