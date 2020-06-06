variable "my-access-key" {
  type = "string"
}

variable "my-secret-key" {
  type = "string"
}

variable "vscale_api_token" {
  type = "string"
}

variable "aws_region" {
  type = "string"
  default = "us-west-2"
}

variable "zone" {
  type = "string"
  default = "devops.rebrain.srwx.net"
}

variable "filename" {
  type = "string"
  default = "devs.txt"
}

variable "devs" {
  type = "list"
  default = [
    "dev1.dan4ex",
    "dev2.dan4ex"
  ]
}

variable "name" {
  type    = "string"
  default = "Osipov_Daniil"
}

variable "rplan" {
  type    = "string"
  default = "small"
}

variable "location" {
  type    = "string"
  default = "msk0"
}

variable "make_from" {
  type    = "string"
  default = "ubuntu_16.04_64_001_master"
}

variable "ssh_key" {
  type    = "string"
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCwPxJuSYrlQwMyjqR8dbr3TaGncahRmSpNXUorRqDjPsNRWp23b0gLrHDDzbZ9PysmPgJohmSapTUVqGnyL0n59+kCeejXGPslPF/Iy8Y6furfRZwFmL8yEYhuipyV7MTQ/q2lkP3n0rs/vdSQ4BCMA6Nv+N57coqPC9MN0cMZmoPedQ/nN2tkh46TKh59UIzAwx/zHtRlfNoTPu4nbMiAyjvJeGws2DcbhhrKLOeq+MxvUgQVjbz2YVpCx4WBbpp4vKZYdkuaUTczU21B7Gm7fVOjGI7Oj802aIZHb9jndY6GfkjMataXGdZ5c/HcVpcEf3P5tCMgYjbaNnhNBKifK6vz54ABcslqXZw0QsNs1aVua3Zjom8gu6ZK6lJPWHXYMM4y/93oRNu0/JcoagEaEMdwJfuYcLg9VF8HqYjb3KI+ayXpFYlNVVurZhCxN3bszm74bo00vVaAIA5pcaNWqYztBxztTnSG39wgREflvazK5qJxKB2XIuWqjxyMKw/hYEbyUOtWRAISddZFsfRRgfK8Yy75EPfgeOYJFxQJKgbhJp8vq5PtHdLTlUXP/RQYVWAuELhsgbTtTBZaSO/01+O1uqNyxETz6aMFBTSy8ZwLFUU3+qvyQ39AdQPZSfVk46GB0mi0Qx7nfUWyR22oNodibAW9oHu/ZwfOEG1kiQ== dan4ex@yandex.ru"
}

variable "ssh_key_name" {
  type    = "string"
  default = "Osipov_Daniil"
}
