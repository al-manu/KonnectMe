# Terraform variables for the DEV environment
# These variables define the names of the S3 buckets used for different stages in the data pipeline.

# The input S3 bucket where raw data is ingested.
in_bucket_name = "dwh-dev-ingestion"

# The output S3 bucket where transformed data is staged.
out_bucket_name = "dwh-dev-stagingg"

# Temporary S3 bucket for refined/processed data.
tmp_bucket_name = "dwh-dev-refined"

# The S3 bucket for exporting curated data to be consumed by other systems or processes.
export_bucket_name = "dwh-dev-curated"

# # Optionally add other variables for the S3 configuration (e.g., versioning, encryption)
# enable_versioning = true  # Enable versioning for the buckets (recommended for production environments)


# dev.tfvars (Environment-specific values)

# Redshift Variables
redshift_db_name         = "dwhtest1"
redshift_master_username = "admin"
redshift_master_password = "MySecurePassword1234!"
base_capacity            = 0  # Redshift Serverlesss minimal capacity
# VPC and Networking Variables
cidr_block            = "10.0.0.0/16"
public_subnet_cidr    = "10.0.0.0/22"
private_subnet_cidr   = "10.0.4.0/22"
public_subnet_az      = "eu-central-1a"
private_subnet_az     = "eu-central-1b"

