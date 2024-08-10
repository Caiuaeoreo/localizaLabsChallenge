resource "aws_s3_bucket" "terraform_state" {
  bucket = "caiua-localiza-terraform-state-bucket"
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

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"
}