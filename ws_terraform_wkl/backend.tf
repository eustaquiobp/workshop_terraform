terraform {
  backend "s3" {
    bucket = "terraform-state-workshop-unmd"
    region = "us-east-1"
  }
}
