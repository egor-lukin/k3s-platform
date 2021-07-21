terraform {
  required_providers {
    hcloud = {
      source = "terraform-providers/hcloud"
    }

    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  required_version = ">= 0.13"
}
