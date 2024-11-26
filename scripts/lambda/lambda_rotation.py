import boto3
import random
import string
import json
from botocore.exceptions import ClientError

secrets_client = boto3.client('secretsmanager')
redshift_client = boto3.client('redshift-data')

def generate_password(length=12):
    """Generate a random password."""
    chars = string.ascii_letters + string.digits + string.punctuation
    return ''.join(random.choice(chars) for i in range(length))

def update_redshift_password(secret_arn, username, new_password):
    """Update Redshift user password."""
    try:
        # Here, replace `redshift_cluster_id` with your Redshift cluster ID
        cluster_id = 'your-redshift-cluster-id'

        # This will run SQL to change the password
        query = f"ALTER USER {username} WITH PASSWORD '{new_password}'"
        
        response = redshift_client.execute_statement(
            ClusterIdentifier=cluster_id,
            Database='your-database-name',
            SecretArn=secret_arn,
            Sql=query
        )

        return response
    except ClientError as e:
        print(f"Error updating Redshift password: {e}")
        raise e

def lambda_handler(event, context):
    secret_arn = event['SecretId']
    secret_value = secrets_client.get_secret_value(SecretId=secret_arn)
    secret = json.loads(secret_value['SecretString'])

    # Extract current username and other information
    username = secret['username']
    
    # Generate new password
    new_password = generate_password()
    print(f"Generated new password: {new_password}")
    
    # Update the password in Secrets Manager
    secrets_client.put_secret_value(
        SecretId=secret_arn,
        SecretString=json.dumps({
            'username': username,
            'password': new_password,
            'dbname': secret['dbname']
        })
    )
    
    # Update Redshift password
    update_redshift_password(secret_arn, username, new_password)

    return {
        'statusCode': 200,
        'body': json.dumps('Password rotation successful')
    }
