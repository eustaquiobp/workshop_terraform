
output "s3_bucket_id" {
  description = "ID do Bucket S3 criado para uploads"
  value       = aws_s3_bucket.uploads.id
}

output "s3_bucket_arn" {
  description = "ARN do Bucket S3 criado para uploads"
  value       = aws_s3_bucket.uploads.arn
}

output "custom_combined_output" {
  description = "Nome do Bucket S3 - nome da Função Lambda"
  value       = "${aws_s3_bucket.uploads.id}-${aws_lambda_function.process_files.function_name}"
}

output "repo_s3" {
  description = "Nome do repositório"
  value       = "${local.repository}"
}
