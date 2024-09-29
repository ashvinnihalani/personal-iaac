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
  }
}


variable "DO_PAT" {
  type    = string
  default = ""
}

provider "digitalocean" {
  token = var.DO_PAT
}