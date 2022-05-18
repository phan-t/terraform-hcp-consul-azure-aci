variable "region" {
  description = "Azure region"
  type        = string
}

variable "deployment_id" {
  description = "Deployment id"
  type        = string
}

variable "vnet_cidrs" {
  type        = list(string)
  description = "The ciders of the vnet"
  default     = ["10.0.0.0/16"]
}

variable "vnet_subnets" {
  type        = map(string)
  description = "The subnets associated with the vnet"
  default = {
    "aci-snet" = "10.0.1.0/24",
    "vm-snet"  = "10.0.2.0/24",
  }
}