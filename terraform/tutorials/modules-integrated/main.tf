module "resource_group" {
  source   = "app.terraform.io/cheeseboy/resource-group/azurerm"
  version  = "1.0.13"
  for_each = { for key, value in var.resource_groups : key => value }

  name     = each.value.name
  location = each.value.location

  tags = merge(var.required_tags, each.value.tags)
}

module "network_watcher" {
  source   = "app.terraform.io/cheeseboy/network-watcher/azurerm"
  version  = "0.1.2"
  for_each = { for key, value in var.network_watchers : key => value }

  name                = each.value.name
  resource_group_name = module.resource_group[each.value.rg_key].name
  location            = module.resource_group[each.value.rg_key].location

  tags = merge(var.required_tags, each.value.tags)
}

module "virtual_network" {
  source   = "app.terraform.io/cheeseboy/virtual-network/azurerm"
  version  = "0.1.1"
  for_each = { for key, value in var.virtual_networks : key => value }

  name                = each.value.name
  resource_group_name = module.resource_group[each.value.rg_key].name
  location            = module.resource_group[each.value.rg_key].location
  address_space       = each.value.address_space

  bgp_community           = lookup(each.value, "bgp_community", null)
  dns_servers             = lookup(each.value, "dns_servers", null)
  edge_zone               = lookup(each.value, "edge_zone", null)
  flow_timeout_in_minutes = lookup(each.value, "flow_timeout_in_minutes", 4)

  ddos_protection_plan = lookup(each.value, "ddos_protection_plan", null)

  encryption = lookup(each.value, "encryption", null)

  tags = merge(var.required_tags, each.value.tags)
}

module "subnet" {
  source   = "app.terraform.io/cheeseboy/subnet/azurerm"
  version  = "0.1.9"
  for_each = { for key, value in var.subnets : key => value }

  name                 = each.value.name
  resource_group_name  = module.resource_group[each.value.rg_key].name
  virtual_network_name = module.virtual_network[each.value.vnet_key].name
  address_prefixes     = each.value.address_prefixes

  default_outbound_access_enabled               = coalesce(each.value.default_outbound_access_enabled, true)
  private_endpoint_network_policies             = lookup(each.value, "private_endpoint_network_policies", "Enabled")
  private_link_service_network_policies_enabled = coalesce(each.value.private_link_service_network_policies_enabled, true)
  service_endpoints                             = lookup(each.value, "service_endpoints", [])
  service_endpoint_policy_ids                   = lookup(each.value, "service_endpoint_policy_ids", [])

  delegation = lookup(each.value, "delegation", {})
}

output "subnet_pe_network_policies" {
  value = module.subnet["subnet1"].private_endpoint_network_policies
}
