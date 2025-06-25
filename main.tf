provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  default = "us-east-1"
}

resource "aws_s3_bucket" "data_bucket" {
  bucket = "x-backet-cloud2"
}

locals {
  folders = ["raw/", "process/"]
}

resource "aws_s3_bucket_object" "folders" {
  for_each     = toset(local.folders)
  bucket       = aws_s3_bucket.data_bucket.id
  key          = each.value
  content      = ""
  content_type = "application/x-directory"
}

resource "aws_s3_bucket_object" "upload_csv" {
  bucket       = aws_s3_bucket.data_bucket.id
  key          = "raw/data.csv"
  source       = "uploads/data.csv"
  content_type = "csv"
}
