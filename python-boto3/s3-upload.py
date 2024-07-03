import boto3

s3 = boto3.client('s3')

s3.upload_file('local-file.txt', 'my-bucket', 'remote-file.txt')

response = s3.list_buckets()
for bucket in response['Buckets']:
    print(bucket['Name'])

