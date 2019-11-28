import os
import boto3

endpoint_url = os.getenv('DYNAMODB_ENDPOINT', None)
table_name = os.getenv('TABLE_NAME', None)
dynamodb = boto3.client('dynamodb', endpoint_url=endpoint_url)

dynamodb.create_table(
  TableName=table_name,
  KeySchema=[
    {
      'AttributeName': 'id',
      'KeyType': 'HASH'
    }
  ],
  AttributeDefinitions=[
    {
      'AttributeName': 'id',
      'AttributeType': 'N'
    }
  ],
  ProvisionedThroughput={
    'ReadCapacityUnits': 1,
    'WriteCapacityUnits': 1
  }
)
dynamodb.put_item(TableName=table_name, Item={'id': {'N': '1001'}})
