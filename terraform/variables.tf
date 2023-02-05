# Use variables to customize the deployment


# Environment Variables



# Resource Group Name
variable "resource_group_name" {
  type    = string
  default = "arc-nested-rg"

}

# Resource Location
variable "location" {
  type    = string
  default = "East US"

}

# Virtual Machine Variables
variable "vm_name" {
  type    = string
  default = "nested-vm-01"
}

variable "nested_vm_network_name" {
  type    = string
  default = "vnet-01"
}

variable "nic_name" {
  type    = string
  default = "nested-vm-nic-01"

}

variable "nsg_name" {
  type    = string
  default = "internal-nsg-01"

}

variable "pip_name" {
  type    = string
  default = "vm-nic-pip-01"

}

# Stroage Account Variables

variable "storage_account_name" {
  type    = string
  default = "isostore67432"

}

variable "container_name" {
  type    = string
  default = "iso"
}




