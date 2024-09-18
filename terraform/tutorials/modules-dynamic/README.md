# Dynamic Modules

This tutorial is designed to teach the principles behind dynamic deployment of resources with Terraform. It calls a resource group module in a private Terraform Cloud registry. It uses `for_each` loops with nested `for` expressions to dynamically create an arbitrarily large number of resource groups with a single module call.
