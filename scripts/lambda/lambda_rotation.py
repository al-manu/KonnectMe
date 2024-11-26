import boto3
import random
import string
import json
from botocore.exceptions import ClientError

# Initialize clients for Secrets Manager and Redshift
secretsmanager_client = boto3.client('secretsmanager')
redshift_client = boto3.client('redshift')

def lambda_handler(event, context):
    secret_id = event['SecretId']
    try:
        # Get the current secret value from Secrets Manager
        current_secret = secretsmanager_client.get_secret_value(SecretId=secret_id)
        secret = json.loads(current_secret['SecretString'])

        # Generate a new password (you can adjust the password complexity)
        new_password = generate_random_password()

        # Update the secret with the new password
        secret['password'] = new_password
        secretsmanager_client.put_secret_value(
            SecretId=secret_id,
            SecretString=json.dumps(secret)
        )

        # Update the Redshift cluster with the new password
        update_redshift_credentials(new_password)

        return {
            'statusCode': 200,
            'body': json.dumps('Password rotation successful.')
        }

    except ClientError as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f'Error: {str(e)}')
        }

def generate_random_password(length=16):
    """Generate a random password containing uppercase, lowercase, numbers, and special characters."""
    characters = string.ascii_letters + string.digits + string.punctuation
    return ''.join(random.choice(characters) for i in range(length))

def update_redshift_credentials(new_password):
    """Update Redshift cluster with the new password."""
    # Replace with actual cluster identifier and credentials update logic
    cluster_id = 'your-cluster-id'
    db_user = 'admin'  # Replace with your actual DB user

    redshift_client.modify_cluster(
        ClusterIdentifier=cluster_id,
        MasterUserPassword=new_password
    )
