import boto3
import json
import random
import string
from botocore.exceptions import ClientError

# Initialize AWS clients
secrets_client = boto3.client('secretsmanager')
redshift_data_client = boto3.client('redshift-data')
redshift_serverless_client = boto3.client('redshift-serverless')

def generate_password(length=12):
    """Generate a random password."""
    chars = string.ascii_letters + string.digits + string.punctuation
    return ''.join(random.choice(chars) for _ in range(length))

def get_redshift_workgroup_and_namespace():
    """Fetch the Redshift Serverless Workgroup and Namespace dynamically."""
    workgroups = redshift_serverless_client.list_workgroups()
    namespaces = redshift_serverless_client.list_namespaces()

    if not workgroups['workgroups']:
        raise ValueError("No workgroups found in Redshift Serverless.")
    if not namespaces['namespaces']:
        raise ValueError("No namespaces found in Redshift Serverless.")

    workgroup_name = workgroups['workgroups'][0]['workgroupName']
    namespace_name = namespaces['namespaces'][0]['namespaceName']

    return workgroup_name, namespace_name

def update_redshift_password(secret_arn, username, new_password, workgroup_name, database_name):
    """Update the Redshift password via Redshift Data API."""
    query = f"ALTER USER {username} WITH PASSWORD '{new_password}'"
    try:
        response = redshift_data_client.execute_statement(
            WorkgroupName=workgroup_name,
            Database=database_name,
            SecretArn=secret_arn,
            Sql=query
        )
        return response
    except ClientError as e:
        print(f"Error updating Redshift password: {e}")
        raise e

def lambda_handler(event, context):
    secret_arn = event['SecretId']
    
    # Get the secret value
    secret_value = secrets_client.get_secret_value(SecretId=secret_arn)
    secret = json.loads(secret_value['SecretString'])

    username = secret['username']
    database_name = secret.get('dbname', 'default')  # Update default database if needed

    # Generate a new password
    new_password = generate_password()
    print(f"Generated new password: {new_password}")

    # Update the secret in Secrets Manager
    secrets_client.put_secret_value(
        SecretId=secret_arn,
        SecretString=json.dumps({
            "username": username,
            "password": new_password
        })
    )

    # Fetch Workgroup and Namespace
    workgroup_name, namespace_name = get_redshift_workgroup_and_namespace()

    # Update the password in Redshift
    update_redshift_password(secret_arn, username, new_password, workgroup_name, database_name)

    return {
        'statusCode': 200,
        'body': 'Password rotation successful.'
    }
