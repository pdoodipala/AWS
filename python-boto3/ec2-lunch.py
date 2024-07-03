import boto3

ec2 = boto3.client('ec2')

response = ec2.run_instances(
    ImageId='ami-0abcdef1234567890',
    InstanceType='t2.micro',
    MinCount=1,
    MaxCount=1,
    KeyName='my-key-pair',
    SecurityGroupIds=['sg-0123456789abcdef0'],
    SubnetId='subnet-0123456789abcdef0'
)