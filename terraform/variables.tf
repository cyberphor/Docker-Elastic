variable "location" {
  type = string
  default = "eastus"
}

variable "resource_group" {
  type = string
  default = null
}

variable "image" {
  type    = string
  default = null
}

variable "image_version" {
  type    = string
  default = "v1.0.0"
}

variable "container_port" {
  type    = number
  default = 1337
}

variable "share_name" {
  type    = string
  default = null
}

variable "volume_mount_path" {
  type    = string
  default = null
}