terraform {
  required_providers {
    zedcloud = {
      source  = "zededa/zedcloud"
      version = ">= 2.5.0"
    }
  }
}

provider "zedcloud" {
  zedcloud_url   = var.zededa_controller_url
  zedcloud_token = var.zededa_token
}

resource "zedcloud_network_instance" "network_instance" {
  port      = var.port
  name      = var.name
  title     = var.title
  kind      = var.kind
  type      = var.type
  device_id = var.device_id

  ip {
    dhcp_range {
      start = var.ip_range.start
      end   = var.ip_range.end
    }
    dns    = var.ip_range.dns
    domain = var.ip_range.domain
    gateway = var.ip_range.gateway
    subnet  = var.ip_range.subnet
  }
}