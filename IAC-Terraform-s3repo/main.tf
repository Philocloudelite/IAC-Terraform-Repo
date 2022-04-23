
resource "aws_s3_bucket" "iac_s3_bucket" {
  count =  length(var.s3_Name)
  bucket = var.s3_name[count.index]
  versioning  = true

  tags = {
    Name        = var.s3_name[count.tndex]
  }

}


resource "aws_dynamodb_table" "dynamodb-terraform-lock" {
  name           = "terraform-lock"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }
}
