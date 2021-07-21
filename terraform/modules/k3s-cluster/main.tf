resource "hcloud_server" "master" {
  name = var.master_node.name
  image = var.master_node.image
  server_type = var.master_node.server_type

  ssh_keys = var.ssh_keys

  provisioner "local-exec" {
    command = <<EOT
            sleep 60;
            k3sup install \
            --ip ${self.ipv4_address} \
            --context k3s \
            --ssh-key ${var.private_ssh_key} \
            --user ${var.user} \
            --k3s-version ${var.k3s_version} \
            --k3s-extra-args '${var.k3s_extra_args}'
        EOT
  }
}

resource "hcloud_server" "node" {
  for_each = { for node in var.worker_nodes: node.name => node }

  name = each.value.name
  image = each.value.image
  server_type = each.value.server_type

  ssh_keys = var.ssh_keys

  provisioner "local-exec" {
    command = <<EOT
            sleep 60;
            k3sup join \
            --ip ${self.ipv4_address} \
            --server-ip ${hcloud_server.master.ipv4_address} \
            --ssh-key ${var.private_ssh_key} \
            --user ${var.user}
        EOT
  }

  depends_on = [
    hcloud_server.master
  ]
}
