# Configure remote state for pipeline. Replace with your bucket and table.
# Uncomment the s3 backend and remove the local block when using CI/CD.
#
# backend "s3" {
#   bucket         = "your-terraform-state-bucket"
#   key            = "awslab/terraform.tfstate"
#   region         = "us-east-1"
#   dynamodb_table = "your-terraform-locks"
#   encrypt        = true
# }

backend "local" {
  path = "terraform.tfstate"
}
