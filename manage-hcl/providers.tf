terraform {
  required_version = ">=1.7.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }

  backend "s3" {
    bucket = "tf-stateful-bucket"
    key    = "state.tfstate"
    region = "eu-central-1"
    use_lockfile = true
    # dynamodb_table = "tf-stateful-dynamo_db" --deprecated
  }


}

provider "aws" {
  region = "eu-central-1"
}
