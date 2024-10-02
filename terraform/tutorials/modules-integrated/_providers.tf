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
