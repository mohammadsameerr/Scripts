resource "aws_s3_bucket" "s3" {
  bucket = "sameerrrrr111"
}

resource "aws_s3_bucket_website_configuration" "static" {
  bucket = aws_s3_bucket.s3.id

  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.s3.id

  acl = "public-read"
}

resource "aws_s3_bucket_policy" "bucketpolicy" {
  bucket = aws_s3_bucket.s3.id

 

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.s3.arn,
          "${aws_s3_bucket.s3.arn}/*",
        ]
      },
    ]
  })
}