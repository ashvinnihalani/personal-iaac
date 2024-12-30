terraform {
  backend "remote" {
    organization = "AshvinNihalani"

    workspaces {
      name = "personal-infrastructure"
    }
  }
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "digitalocean" {
  token = var.DO_PAT
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

module "atuin" {
  source = "./atuin"
}