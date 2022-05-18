output "consul_root_token" {
  value     = module.consul.root_token
  sensitive = true
}

output "consul_public_address" {
  value = module.consul.public_address
}

output "next_steps" {
  value = "Use 'terraform output consul_root_token' to retrieve the root token."
}