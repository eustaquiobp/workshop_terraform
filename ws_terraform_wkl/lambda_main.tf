resource "aws_lambda_function" "process_files" {
  filename         = "lambda_function.zip"
  function_name    = "teste-ProcessFiles-${local.environment}"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.8"
  memory_size      = var.lambda_memory_size
  timeout          = var.lambda_timeout

  tags = merge(local.common_tags, {
    Name = "Lambda Function ${local.environment}"
  })

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.results.name
    }
  }

  provisioner "local-exec" { 
    command = "aws s3 cp lambda_function.py s3://${aws_s3_bucket.uploads.bucket}/lambda_function.py" 
    }

}

resource "aws_lambda_permission" "s3_trigger" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.process_files.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.uploads.arn
}