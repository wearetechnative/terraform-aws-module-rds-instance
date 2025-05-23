terraform {
  required_version = ">= 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.8.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.1.2"
    }
  }
}
