variable "private_key_path" {
  description = "Path to the private key used for provisioners"
}

variable "external_ip_address_app" {
  description = "External IP-address of Reddit App"
}

variable "internal_ip_address_db" {
  description = "Internal IP-address of MongoDB"
}

variable "proxy_port" {
  description = "TCP-port for Nginx Proxy"
}
