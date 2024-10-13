subnets = {
  subnet1 = {
    name             = "subnet1"
    rg_key           = "dev_network_rg"
    vnet_key         = "demo_vnet_1"
    address_prefixes = ["10.1.0.0/24"]
  }
  subnet2 = {
    name             = "aks-subnet"
    rg_key           = "dev_network_rg"
    vnet_key         = "demo_vnet_1"
    address_prefixes = ["10.1.0.0/24"]
    delegation = {
      name = "aks-delegation"
      service_delegation = {
        name    = "Microsoft.ContainerService/managedClusters"
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    }
  }
}
