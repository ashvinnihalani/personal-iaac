terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_droplet" "atuin-server" {
  image   = "docker-20-04"
  name    = "atuin-server"
  region  = "nyc2"
  size    = "s-1vcpu-1gb"
  backups = true
  backup_policy {
    plan    = "weekly"
    weekday = "TUE"
    hour    = 8
  }
  ssh_keys = [44628444, 30997463]
}

resource "digitalocean_database_cluster" "atuin-postgres" {
  name       = "atuin-postgres-cluster"
  engine     = "pg"
  version    = "15"
  size       = "db-s-1vcpu-1gb"
  region     = "nyc1"
  node_count = 1
}

resource "digitalocean_database_db" "atuin-postgres" {
  cluster_id = digitalocean_database_cluster.atuin-postgres.id
  name       = "autin-postgres-cluster-db"
}

resource "digitalocean_database_firewall" "atuin-postgres-fw" {
  cluster_id = digitalocean_database_cluster.atuin-postgres.id

  rule {
    type  = "droplet"
    value = digitalocean_droplet.atuin-server.id
  }
}