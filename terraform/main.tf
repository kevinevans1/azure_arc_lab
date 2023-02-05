
resource "azurerm_resource_group" "nested_vm_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "nested_vm_network" {
  name                = var.nested_vm_network_name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
  depends_on = [
    azurerm_resource_group.nested_vm_rg
  ]
}

resource "azurerm_public_ip" "vm_nic_01_pip" {
  name                = var.pip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  depends_on = [
    azurerm_resource_group.nested_vm_rg
  ]

  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet" "internal_subnet" {
  name                 = "internal"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.nested_vm_network_name
  address_prefixes     = ["10.0.2.0/24"]
  depends_on = [
    azurerm_virtual_network.nested_vm_network
  ]
}


resource "azurerm_network_interface" "nested_vm_nic_1" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name
  depends_on = [
    azurerm_subnet.internal_subnet
  ]


  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_nic_01_pip.id
  }
}

resource "azurerm_network_security_group" "internal_subnet_nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  depends_on = [
    azurerm_subnet.internal_subnet
  ]

  security_rule {
    name                       = "rdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


resource "azurerm_windows_virtual_machine" "windows_vm_nested" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  depends_on = [
    azurerm_network_interface.nested_vm_nic_1
  ]
  size                     = "Standard_D8s_v3"
  admin_username           = "adminuser"
  admin_password           = "P@$$w0rd1234!"
  enable_automatic_updates = "true"
  network_interface_ids = [
    azurerm_network_interface.nested_vm_nic_1.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = "256"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

# ISO Storage Account
resource "azurerm_storage_account" "iso_store" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "iso_container" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.iso_store.name
  container_access_type = "private"
  depends_on = [
    azurerm_storage_account.iso_store
  ]
}
