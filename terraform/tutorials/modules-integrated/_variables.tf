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
