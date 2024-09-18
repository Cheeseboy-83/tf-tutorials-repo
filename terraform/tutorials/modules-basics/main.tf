terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.109"
    }
  }
  
  backend "azurerm" {
    key              = "modules-basic.tfstate"
    use_oidc         = true
    use_azuread_auth = true
  }
}

provider "azurerm" {
  features {}
  subscription_id = "783a2d1e-205e-40e1-a827-19bfd1d86396"
}

module "resource_group" {
  source  = "app.terraform.io/cheeseboy/resource-group/azurerm"
  version = "1.0.11"

  name     = "rg-terraform-tutorial"
  location = "westus"
  tags = merge(var.required_tags, {
    environment = "dev"
  })
}