resource "aws_iam_role" "gluerole" {
  name  = "gluejob-role"
  tags  = {
    name = "iamgluejob"
  }
 
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sts:AssumeRole"
        ]
        Principal = {
          "Service" = "glue.amazonaws.com"
        }
      }
    ]
  })
 
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
  ]
}
 
resource "aws_s3_bucket" "s3bucket" {
  bucket = "gluejob-buc"
}
 

resource "aws_glue_job" "glue_job" {
  name = "glue-job"
  role_arn = aws_iam_role.gluerole.arn
 

  command {
    name = "gluestreaming"
    script_location = "s3://${aws_s3_bucket.s3bucket.bucket}/s3bucket.script"
  }
}

