resource "aws_s3_bucket" "uploads" {
  bucket = "ws-unmd-${local.environment}"

  tags = merge(local.common_tags, {
    Name = "ws-unmd-${local.environment}"
  })
}

resource "aws_s3_object" "lambda_code" {
  bucket = aws_s3_bucket.uploads.bucket
  key    = "code/lambda_function.zip"
  source = "lambda_function.zip"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.uploads.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.process_files.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.s3_trigger]
}
