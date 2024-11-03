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

variable "DO_PAT" {
  type    = string
  default = ""
}

variable "AWS_ACCESS_KEY_ID" {
  type    = string
  default = ""
}

variable "AWS_SECRET_ACCESS_KEY" {
  type    = string
  default = ""
}
provider "digitalocean" {
  token = var.DO_PAT
}

provider "aws" {
  region     = "us-west-2"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}