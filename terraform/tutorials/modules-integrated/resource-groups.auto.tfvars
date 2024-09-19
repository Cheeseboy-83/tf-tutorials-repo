resource_groups = {
  dev_network_rg = {
    name     = "rg-network-dev"
    location = "westus"
    tags = {
      environment = "dev"
    }
  }
  prod_network_rg = {
    name     = "rg-network-prod"
    location = "eastus"
    tags = {
      environment = "prod"
    }
  }
}