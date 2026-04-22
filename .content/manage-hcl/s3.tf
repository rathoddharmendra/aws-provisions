
resource "random_pet" "this" {
  length    = 2
  separator = "-"
}

resource "random_string" "random" {
  length           = 16
  special          = true
  override_special = "/@£$"
}

output "name" {
  value = random_string.random.result
}


resource "random_id" "bucket_suffix" {
  byte_length = 8
}

resource "aws_s3_bucket" "bucket_name" {
  bucket = "my-bucket-${random_id.bucket_suffix.hex}"
}

output "bucket_name" {
  value = aws_s3_bucket.bucket_name.bucket
}
