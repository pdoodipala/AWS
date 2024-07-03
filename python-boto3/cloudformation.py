import boto3

cloudformation = boto3.client('cloudformation')

response = cloudformation.create_stack(
    StackName='my-stack',
    TemplateURL='https://s3.amazonaws.com/mybucket/mytemplate.json',
    Parameters=[
        {
            'ParameterKey': 'KeyName',
            'ParameterValue': 'my-key-pair'
        },
    ],
    Capabilities=[
        'CAPABILITY_NAMED_IAM',
    ]
)
