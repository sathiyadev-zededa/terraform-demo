
variable "device_id" {
  description = "The ID of the device for the network instance"
  type        = string
}

variable "ip_range" {
  description = "IP configuration for the network instance"
  type = object({
    start   = string
    end     = string
    gateway = string
    subnet  = string
    dns     = list(string)
    domain  = string
  })
}

variable "port" {
  description = "The port for the network instance (e.g., eth0)"
  type        = string
  default     = "eth0"
}

variable "name" {
  description = "The name of the network instance"
  type        = string
}

variable "title" {
  description = "The title of the network instance"
  type        = string
}

variable "kind" {
  description = "The kind of network instance"
  type        = string
  default     = "NETWORK_INSTANCE_KIND_LOCAL"
}

variable "type" {
  description = "The type of network instance"
  type        = string
  default     = "NETWORK_INSTANCE_DHCP_TYPE_V4"
}
variable "zededa_controller_url" {
    description = "zededa controller url"
    type        = string
    default     = "https://zedcontrol.gmwtus.zededa.net"
}

variable "zededa_token" {
    description = "zededa token"
    type        = string
    default     = ""
  
}