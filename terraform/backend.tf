provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "caiua-localiza-terraform-state-bucket"
    key            = "terraform/state.tfstate"
    region         = "us-east-1"
  }
}