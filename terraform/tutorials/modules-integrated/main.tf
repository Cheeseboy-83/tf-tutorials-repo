terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.109"
    }
  }
  cloud {
    organization = "cheeseboy"
    workspaces {
      name = "modules-integrated"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "783a2d1e-205e-40e1-a827-19bfd1d86396"
}

module "resource_group" {
  source   = "app.terraform.io/cheeseboy/resource-group/azurerm"
  version  = "1.0.13"
  for_each = { for key, value in var.resource_groups : key => value }

  name     = each.value.name
  location = each.value.location
  tags     = merge(var.required_tags, each.value.tags)
}

module "network_watcher" {
  source   = "app.terraform.io/cheeseboy/network-watcher/azurerm"
  version  = "0.1.2"
  for_each = { for key, value in var.network_watchers : key => value }

  name                = each.value.name
  resource_group_name = module.resource_group[each.value.rg_key].name
  location            = module.resource_group[each.value.rg_key].location
  tags                = merge(var.required_tags, each.value.tags)
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
