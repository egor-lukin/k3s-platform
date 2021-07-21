variable "hcloud_token" {}

provider "hcloud" {
  token = var.hcloud_token
}
