
aws dynamodb create-table    --table-name terraform-dev-state-table  --attribute-definitions AttributeName=LockID,AttributeType=S  --key-schema AttributeName=LockID,KeyType=HASH --billing-mode PAY_PER_REQUEST   --region ap-southeast-2
