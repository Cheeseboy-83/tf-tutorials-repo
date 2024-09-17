variable "required_tags" {
  type = map(string)
  default = {
    owner  = "cheeseboy"
    source = "terraform-tutorial"
  }
}