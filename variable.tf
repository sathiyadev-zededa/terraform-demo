variable "zededa_controller_url" {
  description = "zededa cloud URL"
  type        = string
}

variable "zededa_token" {
  description = "Zededa cloud access token"
  type        = string
}

variable "node1" {
  description = "edge node name1"
  default     = "node1"
  type        = string
}

variable "node2" {
  description = "edge node name2"
  default     = "node2"
  type        = string 
}

variable "serial1" {
  description = "Serial number for node1"
  type        = string
  default     = ""
}

variable "serial2" {
  description = "Serial number for node2"
  type        = string
  default     = ""
}

variable "project_name" {
  description = "project name"
  default     = "demo-barq"
  type        = string
}

variable "interface" {
    description = "physical-interface-name"
    default = "eth0"
    type= string
}

variable "network" {
    description = "adapter configuration"
    default = "dhcp-demo-config"
    type= string
}

variable "model_id" {
    description = "ZedVirtualDevice model id"
    default = "01c0c06a-b5ce-4f19-be9d-d7fd341556cd"
    type = string
}

variable "onboarding_key" {
    description = "default oboarding key"
    default = ""
    type = string
}

variable "dispatch_url" {
    description = "dispatch url"
    default = ""
    type = string
}

variable "datastore_cidr" {
    default = ""
    description = "datastore cidr"
    type = string
}

variable "datastore_username" {
    default = ""
    description = "datastore username"
    type = string
}

variable "datastore_access_key" {
    default = ""
    description = "datastore access key"
    type = string
}
