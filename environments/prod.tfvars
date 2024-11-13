# Terraform variables for the PROD environment
# These variables define the names of the S3 buckets used for different stages in the data pipeline.

# The input S3 bucket where raw data is ingested.
in_bucket_name = "dwh-prod-ingestion"

# The output S3 bucket where transformed data is staged.
out_bucket_name = "dwh-prod-stagingggg"  

# Temporary S3 bucket for refined/processed data.
tmp_bucket_name = "dwh-prod-refined"

# The S3 bucket for exporting curated data to be consumed by other systems or processes.
export_bucket_name = "dwh-prod-curated"
