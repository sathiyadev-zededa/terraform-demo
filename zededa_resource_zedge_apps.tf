
resource "zedcloud_datastore" "barq_demo" {
  ds_fqdn             = var.datastore_cidr
  ds_type             = "DATASTORE_TYPE_CONTAINERREGISTRY"
  name                = "barq_demo_ds"
  title               = "barq_demo_ds"
  ds_path             = ""
  project_access_list = [zedcloud_project.zededa_project.id]
  secret {
    api_key    = var.datastore_username
    api_passwd = var.datastore_access_key
  }

}

resource "zedcloud_image" "ppe_detection" {
  datastore_id  = zedcloud_datastore.barq_demo.id
  image_type    = "IMAGE_TYPE_APPLICATION"
  image_arch    = "AMD64"
  image_format  = "CONTAINER"
  image_rel_url = "ppe-detection-cpu:3.0"
  depends_on = [
    zedcloud_datastore.barq_demo
  ]
  title               = "ppe_detection_verion1"
  name                = "ppe_detection_version1"
  description         = "Image created for demo"
  project_access_list = [zedcloud_project.zededa_project.id]
}

/*resource "zedcloud_network_instance" "node1_instance" {
    port = "eth0"
    name = "node1-eth0"
    title = "node1-eth0"
    kind = "NETWORK_INSTANCE_KIND_LOCAL"
    type = "NETWORK_INSTANCE_DHCP_TYPE_V4"
    device_id = zedcloud_edgenode.deploy_nodes["node1"].id
    ip {
        dhcp_range {
        end = "10.20.0.30"
        start = "10.20.0.20"
    }
        dns = [
            "1.1.1.1"
        ]
        domain = ""
        gateway = "10.20.0.1"
        subnet = "10.20.0.0/24"
    }
    depends_on = [ zedcloud_edgenode.deploy_nodes["node1"] ]
}

resource "zedcloud_network_instance" "node2_instance" {
    port = "eth0"
    name = "node2-eth0"
    title = "node2-eth0"
    kind = "NETWORK_INSTANCE_KIND_LOCAL"
    type = "NETWORK_INSTANCE_DHCP_TYPE_V4"
    device_id = zedcloud_edgenode.deploy_nodes["node2"].id
        ip {
        dhcp_range {
        end = "10.30.0.30"
        start = "10.30.0.20"
    }
        dns = [
            "1.1.1.1"
        ]
        domain = ""
        gateway = "10.30.0.1"
        subnet = "10.30.0.0/24"
    }
  
}*/
module "node1_network_instance" {
  source = "./modules/zedcloud_network_instance"

  device_id = zedcloud_edgenode.deploy_nodes["node1"].id
  name      = "node1-eth0"
  title     = "node1-eth0"
  port      = "eth0"
  kind      = "NETWORK_INSTANCE_KIND_LOCAL"
  type      = "NETWORK_INSTANCE_DHCP_TYPE_V4"

  ip_range = {
    start   = "10.20.0.20"
    end     = "10.20.0.30"
    gateway = "10.20.0.1"
    subnet  = "10.20.0.0/24"
    dns     = ["1.1.1.1", "8.8.8.8"]
    domain  = ""
  }
}

module "node2_network_instance" {
  source = "./modules/zedcloud_network_instance"

  device_id = zedcloud_edgenode.deploy_nodes["node2"].id
  name      = "node2-eth0"
  title     = "node2-eth0"
  port      = "eth0"
  kind      = "NETWORK_INSTANCE_KIND_LOCAL"
  type      = "NETWORK_INSTANCE_DHCP_TYPE_V4"

  ip_range = {
    start   = "10.20.0.20"
    end     = "10.20.0.30"
    gateway = "10.20.0.1"
    subnet  = "10.20.0.0/24"
    dns     = ["1.1.1.1", "8.8.8.8"]
    domain  = ""
  }
}


resource "zedcloud_application" "ppe_detection_demo" {
  name     = "ppe_detection_demo"
  title    = "ppe_detection_demo"
  networks = 1
  //cpus = 2
  //memory = 4388608
  //storage = 100000000
  manifest {
    ac_kind    = "PodManifest"
    ac_version = "1.2.0"
    name       = "ppe_detection_demo"
    owner {
      user    = "sathiaydev"
      group   = ""
      company = "ZEDEDA"
      website = "www.zededa.com"
      email   = "sathiyadev@zededa.com"
    }
    desc {
      app_category = "APP_CATEGORY_UNSPECIFIED"
      category     = "APP_CATEGORY_terraform"
    }
    images {
      imagename   = zedcloud_image.ppe_detection.name
      imageid     = zedcloud_image.ppe_detection.id
      imageformat = "CONTAINER"
      cleartext   = false
      ignorepurge = false
      maxsize     = 0
    }
    interfaces {
      name         = "eth0"
      type         = ""
      directattach = false
      privateip    = false
      /* Outbound rules */
      acls {
        matches {
          type  = "ip"
          value = "0.0.0.0/0"
        }
      }
      acls {
        matches {
          type  = "ip"
          value = "0.0.0.0/0"
        }
      }
      /* portmapping for ingress traffic */
      acls {
        matches {
          type  = "ip"
          value = "0.0.0.0/0"
        }
        actions {
          portmap = true
          portmapto {
            app_port = 22
          }
        }
        matches {
          type  = "protocol"
          value = "tcp"
        }
        matches {
          type  = "lport"
          value = "30001"
        }
        matches {
          type  = "ip"
          value = "0.0.0.0/0"
        }
      }
      acls {
        matches {
          type  = "protocol"
          value = "tcp"
        }
        matches {
          type  = "lport"
          value = "5000"
        }
        matches {
          type  = "ip"
          value = "0.0.0.0/0"
        }
        actions {
          portmap = true
          portmapto {
            app_port = "5000"
          }
        }
      }
      acls {
        matches {
          type  = "protocol"
          value = "tcp"
        }
        matches {
          type  = "ip"
          value = "0.0.0.0/0"
        }
        matches {
          type  = "lport"
          value = "8080"
        }
        actions {
          portmap = true
          portmapto {
            app_port = "8080"
          }
        }
      }
    }
    vmmode    = "HV_PV"
    enablevnc = true
    resources {
      name  = "resourceType"
      value = "custom"
    }
    resources {
      name  = "cpus"
      value = 2
    }
    resources {
      name  = "memory"
      value = 4194304
    }
    app_type            = "APP_TYPE_CONTAINER"
    deployment_type     = "DEPLOYMENT_TYPE_STAND_ALONE"
    cpu_pinning_enabled = true
  }
  origin_type = "ORIGIN_LOCAL"
  project_access_list = [
  zedcloud_project.zededa_project.id]
}