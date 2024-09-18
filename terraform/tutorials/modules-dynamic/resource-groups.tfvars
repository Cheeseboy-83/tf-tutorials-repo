resource_groups = {
  rg-terraform-tutorial = {
    name     = "rg-terraform-tutorial"
    location = "westus"
    tags = {
      environment = "dev"
    }
  }
  rg-terraform-tutorial-2 = {
    name     = "rg-terraform-tutorial-2"
    location = "eastus"
    tags = {
      environment = "prod"
    }
  }
}