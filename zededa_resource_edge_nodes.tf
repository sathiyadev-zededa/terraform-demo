locals {
  nodes = {
    (var.node1) = var.serial1
    (var.node2) = var.serial2
  }
}

data zedcloud_brand "ZedVirtualDevice" {
    name = "ZedVirtualDevice"
    origin_type = "Imported"
    title = "ZedVirtualDevice"
}
resource "zedcloud_project" "zededa_project" {
    name = var.project_name
    title = var.project_name
    type = "TAG_TYPE_PROJECT"
      edgeview_policy {
      type          = "POLICY_TYPE_EDGEVIEW"
    edgeview_policy {
      access_allow_change = true
      edgeview_allow = true
      edgeviewcfg {
        app_policy {
          allow_app = true
        }
        dev_policy {
          allow_dev = true
        }
        jwt_info {
          disp_url = var.dispatch_url
          allow_sec = 18000
          num_inst = 1
          encrypt = true
        }
        ext_policy {
          allow_ext = true
        }
      }
      max_expire_sec = 2592000
      max_inst = 3
    }
  }
}

resource "zedcloud_network" "terr_interface" {
    name = "terraform_interface_network"
    title = "terraform_interface_network"
    description = "Adapter config created by terraform"
    project_id = zedcloud_project.zededa_project.id
    kind = "NETWORK_KIND_V4"
    ip {
        dhcp = "NETWORK_DHCP_TYPE_CLIENT"
    }
    depends_on = [  zedcloud_project.zededa_project ]
}

resource "zedcloud_edgenode" "deploy_nodes" {
    for_each = local.nodes

    name = each.key
    title = "Node-${each.key}"
    description = "BarQ demo Edge node ${each.key}"
    model_id = var.model_id
    project_id = zedcloud_project.zededa_project.id
    onboarding_key = var.onboarding_key
    serialno = each.value
    admin_state = "ADMIN_STATE_ACTIVE"
    config_item {
        bool_value   = false
        float_value  = 0
        key          = "debug.enable.ssh"
        string_value = "<ssh pub key>"
        uint32_value = 0
        uint64_value = 0
    }
    interfaces {
        cost = 0
        intf_usage = "ADAPTER_USAGE_MANAGEMENT"
        intfname   = "eth0"
        netname    = zedcloud_network.terr_interface.name
    }
    depends_on = [  
        zedcloud_network.terr_interface,
        zedcloud_project.zededa_project
    ]

}