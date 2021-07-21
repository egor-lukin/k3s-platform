terraform {
  backend "remote" {
    organization = "mini-apps-platform"

    workspaces {
      name = "prod"
    }
  }
}

resource "hcloud_ssh_key" "ssh_key" {
  name = "mini-apps-platform"
  public_key = file(".ssh/mini-apps-platform.pub")
}

module "k3s" {
  source = "./../../modules/k3s-cluster"
  user = "root"
  k3s_version = "v1.19.1+k3s1"
  k3s_extra_args = "--no-deploy traefik"

  master_node = {
    name = "master-node"
    image = "debian-9"
    server_type = "cx11"
  }

  worker_nodes = [
    {
      name = "worker-node-1"
      image = "debian-9"
      server_type = "cx11"
    },
    {
      name = "worker-node-2"
      image = "debian-9"
      server_type = "cx11"
    }
  ]

  ssh_keys = [
    hcloud_ssh_key.ssh_key.id
  ]

  private_ssh_key = ".ssh/mini-apps-platform"

  depends_on = [
    hcloud_ssh_key.ssh_key
  ]
}
