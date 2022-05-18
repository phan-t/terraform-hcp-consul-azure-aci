variable "region" {
  description = "HCP HVN region"
  type        = string
  default     = ""
}

variable "deployment_id" {
  description = "Deployment id"
  type        = string
}

variable "cidr_block" {
  description = "HCP HVN cidr block"
  type        = string
}

variable "rg_name" {
  description = "Resource group name"
  type        = string
}

variable "vnet_id" {
  description = "vNet id"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet ids"
  type        = list
}

variable "nsg_name" {
  description = "Network security group name"
  type        = string
}
