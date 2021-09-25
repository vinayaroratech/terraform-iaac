terraform {
  backend "s3" {
    bucket = "landcheck-terra-state-bucket"
    key    = "tfstate"
    region = "us-east-1"
  }
}