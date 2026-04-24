
resource "random_uuid" "random_bucket_suffix" {
}

resource "aws_s3_bucket" "s3_bucket_01" {
  bucket = "${var.bucket_name}-${random_uuid.random_bucket_suffix.result}"
  tags = {
    Name        = "My-bucket-01x2"
    Environment = "Dev"
  }
}

variable "bucket_name" {
  type        = string
  description = "Prefix of the S3 bucket"
  default     = "dee-bucket"
}


output "bucket_id" {
  description = "ID of the S3 bucket"
  value       = aws_s3_bucket.s3_bucket_01.id
}