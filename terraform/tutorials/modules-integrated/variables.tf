variable "required_tags" {
  type = map(string)
  default = {
    owner  = "cheeseboy"
    source = "terraform-tutorial"
  }
}

variable "resource_groups" {
  type = map(object({
    name     = string
    location = string
    tags     = optional(map(string))
  }))
  default     = {}
  description = "Resource groups in the deployment"
}

variable "network_watchers" {
  type = map(object({
    name     = string
    rg_key   = string
    location = optional(string)
    tags     = optional(map(string))
  }))
  default     = {}
  description = "Resource groups in the deployment"
}