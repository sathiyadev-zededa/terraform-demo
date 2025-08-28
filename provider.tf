terraform {
  required_providers {
    zedcloud = {
      source  = "zededa/zedcloud"
      version = "2.5.0"
    }
  }
}

provider "zedcloud" {
  zedcloud_url   = var.zededa_controller_url
  zedcloud_token = var.zededa_token
}
