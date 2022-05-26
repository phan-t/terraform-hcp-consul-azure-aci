<h1>
  <img src="./assets/logo.svg" align="left" height="46px" alt="Consul logo"/>
  <span>HCP Consul with Azure Container Instances</span>
</h1>

## Overview

This terraform module will deploy all the necessary resources to demonstrate the HashiCorp Cloud Platform (HCP) Consul on Microsoft Azure with Azure Container Instances (ACI). It assumes no infrastructure has been provisioned and will deploy the following:

**HashiCorp Cloud Platform (HCP)**
- HashiCorp Virtual Network (HVN)
- HVN to Virtual Network (vNet) Peering
- HVN to vNet Routing
- Consul Server Cluster

**Microsoft Azure**
- Resource Group
- vNet
- Subnets
- Route Table
- Network Security Groups
- Network Adress Translation (NAT) Gateway
- Public IP Address
- Network Profile
- Azure Container Instance

The `aci-helloworld` example container image will be launched together with the Consul container image. The Consul container is running as a sidecar. The Consul agent automatically registers with HCP Consul on Azure. At present, Service Discovery is the primary use case. 

## Architecture

## Usage

1. Update `variables.tf` to include `azure_region`, `hcp_client_id`, `hcp_client_secret` and `hcp_hvn_region`.

    Example of `terraform.tfvars`:

    ```hcl
    deployment_name = "hcpconsul-aci-test"
    azure_region = "westus2"
    hcp_client_id = ""
    hcp_client_secret = ""
    hcp_hvn_region = "westus2"
    ```
2. `terraform init`
3. `terraform plan`
4. `terraform apply`
5. To login to HCP Consul, use `terraform output consul_root_token'` to retrieve the root token

### Prerequisites

This terraform module assumes you have an active HashiCorp Cloud Platform (HCP) and Microsoft Azure subscription. For terraform to provision HCP resources, it requires the `hcp_client_id` and `hcp_client_secret`.