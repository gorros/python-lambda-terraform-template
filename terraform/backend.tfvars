bucket         = "terraform"  # TODO: change name of terraform bucket
key            = "terraform.tfstate"
dynamodb_table = "TerraformStatelockTable" # TODO: Create this table in DynamoDB
region         = "us-east-1" # TODO: change region to corresponding region