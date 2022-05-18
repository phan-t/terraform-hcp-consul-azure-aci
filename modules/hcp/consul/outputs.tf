output "public_address" {
  value     = hcp_consul_cluster.dev.consul_public_endpoint_url
}

output "private_address" {
  value     = hcp_consul_cluster.dev.consul_private_endpoint_url
}

output "root_token" {
  value     = hcp_consul_cluster_root_token.dev-token.secret_id
}

output "ca" {
  value     = hcp_consul_cluster.dev.consul_ca_file
}

output "gossip_encrypt_key" {
  value     = local.gossip_encrypt_key  
}