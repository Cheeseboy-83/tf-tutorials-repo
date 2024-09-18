resource_groups = {
  rg_terraform_tutorial = {
    name     = "rg-terraform-tutorial"
    location = "westus"
    tags = {
      environment = "dev"
    }
  }
  rg_terraform_tutorial_2 = {
    name     = "rg-terraform-tutorial-2"
    location = "eastus"
    tags = {
      environment = "prod"
    }
  }
}