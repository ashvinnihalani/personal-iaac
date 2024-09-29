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

resource "digitalocean_droplet" "www-1" {
  image  = "ubuntu-20-04-x64"
  name   = "www-1"
  region = "nyc3"
  size   = "s-1vcpu-1gb"
}