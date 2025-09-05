locals {
  netinst_names = {
    "node1" = module.node1_network_instance
    "node2" = module.node2_network_instance
  }
}

resource "zedcloud_application_instance" "deploy_application" {
  for_each = local.nodes

  name       = "${each.key}-ppe-detection"
  title      = "${each.key}-ppe-detection"
  project_id = zedcloud_project.zededa_project.id
  app_id     = zedcloud_application.ppe_detection_demo.id
  activate   = true
  device_id  = zedcloud_edgenode.deploy_nodes[each.key].id
  interfaces {
    intfname             = "eth0"
    directattach         = false
    access_vlan_id       = 0
    default_net_instance = false
    ipaddr               = ""
    macaddr              = ""
    netinstname          = local.netinst_names[each.key].name
    privateip            = false
  }
  drives {
    imagename   = zedcloud_image.ppe_detection.name
    cleartext   = false
    ignorepurge = true
    preserve    = false
    readonly    = false
    maxsize     = 1000000
    drvtype     = "HDD"
    target      = "Disk"

  }

}