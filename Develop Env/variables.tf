variable "host_os" {
  type = string
}

variable "username" {
  type = string
  default = "dev_user"
}
variable "keyfile" {
  type = string
  default = "~/.ssh/id_rsa"
}
variable "source_address_prefix" {
  type = string
  default = null 
}