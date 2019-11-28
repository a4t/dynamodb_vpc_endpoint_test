import os
import boto3

endpoint_url = os.getenv('DYNAMODB_ENDPOINT', None)
table_name = os.getenv('TABLE_NAME', None)
dynamodb = boto3.client('dynamodb', endpoint_url=endpoint_url)
item = dynamodb.get_item(TableName=table_name, Key={'id': {'N': '1001'}})
print(item['Item'])
