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

resource "digitalocean_firewall" "atuin-server" {
  name = "atuin-server-22-8888"

  droplet_ids = [digitalocean_droplet.atuin-server.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8888"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
