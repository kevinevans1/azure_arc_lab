
##Use variables to customize the deployment
#Environment Variables

#Resource Group Name
variable "resource_group_name" {
type = string
default = "arc-nested-rg"

#The name of the resource group where the resources will be deployed.
}

#Resource Location
#The location where the resources will be deployed.
variable "location" {
type = string
default = "East US"


}
#The name of the nested virtual machine.
#Virtual Machine Variables
variable "vm_name" {
type = string
default = "nested-vm-01"


}
#The name of the virtual network associated with the nested virtual machine.
variable "nested_vm_network_name" {
type = string
default = "vnet-01"


}
#The name of the network interface associated with the nested virtual machine.
variable "nic_name" {
type = string
default = "nested-vm-nic-01"


}
#The name of the network security group associated with the nested virtual machine.
variable "nsg_name" {
type = string
default = "internal-nsg-01"


}
#The name of the public IP address associated with the network interface of the nested virtual machine.
variable "pip_name" {
type = string
default = "vm-nic-pip-01"


}
#The username for the administrator account of the nested virtual machine.
variable "admin_username" {
type = string


}
#The password for the administrator account of the nested virtual machine.
variable "admin_password" {
type = string


}