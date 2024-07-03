import boto3


rds = boto3.client('rds')

response = rds.create_db_snapshot(
    DBSnapshotIdentifier='my-db-snapshot',
    DBInstanceIdentifier='my-db-instance'
)
