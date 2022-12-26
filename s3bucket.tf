resource "aws_s3_bucket" "bkash_bucket" {
  bucket = "bkash_date_cron_fufh4rw9uhw98_bucket"
}

resource "aws_s3_bucket_public_access_block" "private" {
  bucket = aws_s3_bucket.bkash_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}