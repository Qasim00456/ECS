terraform {
  backend "s3" {
    bucket = "qasim-tf-states"
    key    = "ecs/terraform.tfstate"
    region = "eu-west-2"
  }
}

provider "aws" {
  # Configuration options
  region = "eu-west-2"
}


