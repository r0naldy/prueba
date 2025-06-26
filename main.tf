provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  default = "us-east-1"
}

variable "bucket_name" {
  default = "x-backet-cloud2"  # el bucket ya existe
}

locals {
  folders = ["raw/", "process/"]
}

resource "aws_s3_object" "folders" {
  for_each     = toset(local.folders)
  bucket       = var.bucket_name
  key          = each.value
  content      = ""
  content_type = "application/x-directory"
}

resource "aws_s3_object" "csv_upload" {
  bucket       = var.bucket_name
  key          = "raw/data.csv"
  source       = "uploads/data.csv"
  content_type = "text/csv"
}
#prueba