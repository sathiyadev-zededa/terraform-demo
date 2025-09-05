output "node_names" {
  value = keys(local.nodes)
}

output "node_ids" {
  value = {
    for k, v in zedcloud_edgenode.deploy_nodes : k => v.id
  }
}

