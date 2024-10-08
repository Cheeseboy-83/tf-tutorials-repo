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
      name = "modules-dynamic"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "783a2d1e-205e-40e1-a827-19bfd1d86396"
}

module "resource_group" {
  source   = "app.terraform.io/cheeseboy/resource-group/azurerm"
  version  = "1.0.11"
  for_each = { for key, value in var.resource_groups : key => value }

  name     = each.value.name
  location = each.value.location
  tags     = merge(var.required_tags, each.value.tags)
}