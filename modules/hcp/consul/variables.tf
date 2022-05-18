variable "region" {
  description = "HCP HVN region"
  type        = string
  default     = ""
}

variable "deployment_id" {
  description = "Deployment id"
  type        = string
}

variable "hvn_id" {
  description = "HCP HVN id"
  type        = string
}

variable "tier" {
  description = "HCP consul tier"
  type        = string
}