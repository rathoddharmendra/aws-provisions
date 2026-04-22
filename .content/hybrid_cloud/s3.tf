resource "random_id" "bucket_suffix" {
  byte_length = 8
}

resource "aws_s3_bucket" "bucket_name" {
  bucket = "my-bucket-${random_id.bucket_suffix.hex}"
}


resource "aws_s3_bucket" "bucket_west" {
  bucket = "my-bucket-${random_id.bucket_suffix.hex}-west"
  provider = aws.west
}

output "bucket_name" {
  value = aws_s3_bucket.bucket_name.bucket
}
