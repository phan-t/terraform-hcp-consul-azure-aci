variable "deployment_id" {
  description = "Deployment id"
  type        = string
}

variable "consul_ca" {
  description = "Consul ca"
  type        = string
}

variable "consul_root_token" {
  description = "Consul root token"
  type      = string
}

variable "consul_gossip_encrypt_key" {
  description = "Consul gossip encrypt key"
  type        = string
}

variable "consul_private_address" {
  description = "Consul private address"
  type        = string
}

variable "rg_location" {
  description = "Resource group location"
  type        = string
}

variable "rg_name" {
  description = "Resource group name"
  type        = string
}

variable "nprf_id" {
  description = "Network profile id" 
  type        =  string
}
