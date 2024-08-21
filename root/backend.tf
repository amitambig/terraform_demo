terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket-demo-bucket"
    key = "keys/terraform.tfstate"
    encrypt = true
    region = "us-east-1"
  }
}