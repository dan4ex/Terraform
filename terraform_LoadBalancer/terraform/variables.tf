

variable "awsAccess_key" {
  type = "string"
}

variable "awsSecret_key" {
  type = "string"
}

variable "awsRegion" {
  type = "string"
}

variable "googleProject" {
  type = "string"
}

variable "googleRegion" {
  type = "string"
}

variable "googleVpsName" {
  type = "string"
}

variable "googleVpsMachineType" {
  type = "string"
}

variable "googleVpsZone" {
  type = "string"
}

variable "googleVpsImage" {
  type = "string"
}

variable "sshKey" {
  type = "string"
}

variable "googleVpsNetwork" {
  type = "string"
}

variable "loadBalancerName" {
  type = "string"
}

variable "targetPoolName" {
  type = "string"
}

variable "pathHosts" {
  type = "string"
}

variable "awsRoute53Zone" {
  type = "string"
}

variable "awsRoute53Name" {
  type = "list"
}
