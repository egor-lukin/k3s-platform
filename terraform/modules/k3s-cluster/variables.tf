variable "master_node" {}
variable "worker_nodes" {}

variable "user" {
  type = string
}

variable "k3s_version" {
  type = string
}

variable "k3s_extra_args" {
  type = string
}

variable "private_ssh_key" {}
variable "ssh_keys" {}
