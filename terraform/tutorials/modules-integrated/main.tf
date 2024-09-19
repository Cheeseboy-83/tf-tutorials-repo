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

module "network-watcher" {
  source   = "app.terraform.io/cheeseboy/network-watcher/azurerm"
  version  = "0.1.2"
  for_each = { for key, value in var.resource_groups : key => value }

  name                = each.value.name
  resource_group_name = module.resource_group[each.value.rg_key].name
  location            = module.resource_group[each.value.rg_key].location
  tags                = merge(var.required_tags, each.value.tags)
}