virtual_networks = {
  demo_vnet_1 = {
    name          = "vnet-demo-01"
    rg_key        = "dev_network_rg"
    address_space = ["10.1.0.0/16"]
    tags = {
      environment = "dev"
    }
  }
  demo_vnet_2 = {
    name          = "vnet-demo-02"
    rg_key        = "prod_network_rg"
    address_space = ["10.2.0.0/16"]
    tags = {
      environment = "prod"
    }
  }
}
