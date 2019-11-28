resource "aws_dynamodb_table" "hogehoge" {
  name         = "hogehoge"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "N"
  }

  tags = merge(local.common_tags, {
    Name : "${local.common_name}-dynamodb-hogehoge"
  })
}

resource "aws_dynamodb_table_item" "hogehoge_item1" {
  table_name = aws_dynamodb_table.hogehoge.name
  hash_key   = aws_dynamodb_table.hogehoge.hash_key

  item = <<ITEM
{
  "id": {"N": "1001"}
}
ITEM
}
