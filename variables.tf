variable "deployment_name" {
  description = "Deployment name, used to prefix resources"
  type        = string
  default     = ""
}

variable "azure_region" {
  description = "Azure region"
  type        = string
  default     = ""
}

variable "hcp_client_id" {
  description = "HCP client id"
  type        = string
  default     = ""
}

variable "hcp_client_secret" {
  description = "HCP client secret"
  type        = string
  default     = ""
}

variable "hcp_hvn_region" {
  description = "HCP HVN region"
  type        = string
  default     = ""
}

variable "hcp_hvn_cidr_block" {
  description = "HCP HVN CIDR block"
  type        = string
  default     = "172.25.16.0/20"
}

variable "tier" {
  description = "HCP consul tier"
  type        = string
  default     = "development"
}