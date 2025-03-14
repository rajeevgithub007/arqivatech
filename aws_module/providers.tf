terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-arqi"
    key            = "technical-challenge-2/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-lock-arqi"
    # encrypt        = true
    # kms_key_id     = ""
  }
}
# Terraform Main Configuration (main.tf):
# Update the provider block to use AWS credentials from the default AWS CLI profile and to assume the role for any resource management.

# provider "aws" {
#   region = "eu-west-2"
# }