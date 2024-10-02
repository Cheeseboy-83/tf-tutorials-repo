variable "required_tags" {
  type = map(string)
  default = {
    owner  = "cheeseboy"
    source = "terraform-tutorial"
  }
}

variable "resource_groups" {
  description = "Resource groups in the deployment"
  type = map(object({
    name     = string
    location = string

    tags = optional(map(string))
  }))
  default = {}
}

variable "network_watchers" {
  description = "Resource groups in the deployment"
  type = map(object({
    name   = string
    rg_key = string

    location = optional(string)

    tags = optional(map(string))
  }))
  default = {}
}

variable "virtual_networks" {
  description = "Virtual networks in the deployment"
  type = map(object({
    name          = string
    rg_key        = string
    address_space = list(string)

    location = optional(string)

    bgp_community           = optional(string)
    dns_servers             = optional(list(string))
    edge_zone               = optional(string)
    flow_timeout_in_minutes = optional(number)

    ddos_protection_plan = optional(object({
      id     = string
      enable = bool
    }))

    encryption = optional(object({
      enforcement = bool
    }))

    tags = optional(map(string))
  }))
  default = {}
}

variable "subnets" {
  description = "Subnets in the deployment"
  type = map(object({
    name             = string
    rg_key           = string
    vnet_key         = string
    address_prefixes = list(string)

    default_outbound_access_enabled       = optional(bool)
    private_endpoint_network_policies     = optional(string)
    private_link_service_network_policies = optional(bool)
    service_endpoints                     = optional(list(string))
    service_endpoint_policy_ids           = optional(list(string))

    delegation = optional(object({
      name = string
      service_delegation = list(object({
        name    = string
        actions = list(string)
      }))
    }))

    tags = optional(map(string))
  }))
  default = {}
}
