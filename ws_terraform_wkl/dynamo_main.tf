resource "aws_dynamodb_table" "results" {
  name         = "workshop-results-${local.environment}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = merge(local.common_tags, {
    Name = "DynamoDB Table ${local.environment}"
  })
}
