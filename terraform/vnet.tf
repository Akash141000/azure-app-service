# resource "azurerm_network_security_group" "azureNetworkSecurityGroup" {
#   name                = local.security_group_name
#   location            = local.location
#   resource_group_name = local.resource_group_name
# }


resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = ["172.1.1.0/24"]


  tags = {
    environment = "dev"
  }

  depends_on = [
    azurerm_network_security_group.azureNetworkSecurityGroup
  ]
}

resource "azurerm_subnet" "backend" {
  name                 = "subnet-appservice"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["172.1.1.2/24"]
}

resource "azurerm_subnet" "frontend" {
  name                 = "subnet-gateway"
  resource_group_name  = local.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["172.1.2.3/24"]
}



