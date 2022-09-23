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