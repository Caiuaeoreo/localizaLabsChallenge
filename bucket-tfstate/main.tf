resource "aws_s3_bucket" "terraform_state" {
  bucket = "caiua-localiza-terraform-challenge-state-bucket"
  tags = {
    Name = "Terraform State Bucket"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "terraform_state_dns" {
  bucket = "caiua-localiza-terraform-challenge-dns-state-bucket"
  tags = {
    Name = "Terraform State Bucket DNS"
  }
}

resource "aws_s3_bucket_versioning" "versioning_dns" {
  bucket = aws_s3_bucket.terraform_state_dns.id

  versioning_configuration {
    status = "Enabled"
  }
}