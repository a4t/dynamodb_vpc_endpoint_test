import os
import boto3
import time

endpoint_url = os.getenv('DYNAMODB_ENDPOINT', None)
table_name = os.getenv('TABLE_NAME', None)
dynamodb = boto3.client('dynamodb', endpoint_url=endpoint_url)

start = time.time()
for i in range(100):
    item = dynamodb.get_item(TableName=table_name, Key={'id': {'N': '1001'}})
    print(item['Item'])
elapsed_time = time.time() - start
print ("elapsed_time:{0}".format(elapsed_time) + "[sec]")
