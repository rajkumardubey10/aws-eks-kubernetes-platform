terraform {
  backend "s3" {
    bucket = "remote-backend-bucket-jenkins-159"
    key    = "s3/terraform.tfstate"
    region = "ap-south-1"
    use_lockfile = true
    encrypt = true
  }
}
