variable "OAuthTocken" {
  default = "***"
}

variable "cloud_id" {
  default = "***"
}

variable "image_id" {
  default = "fd81ojtctf7kjqa3au3i" #Debian 11
}

variable "path_terraform" {
  default = "/home/user/terraform"
}

variable "path_ansible" {
  default = "/home/user/ansible"
}


locals {
  web-servers = {
   "web-1" = { zone = "ru-central1-a", subnet_id  = yandex_vpc_subnet.private-subnet-1.id, ip_address = "10.1.0.10" },
   "web-2" = { zone = "ru-central1-b", subnet_id  = yandex_vpc_subnet.private-subnet-2.id, ip_address = "10.2.0.10" }
 }
}
