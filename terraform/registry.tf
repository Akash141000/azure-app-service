resource "azurerm_container_registry" "acr" {
  name                = local.container_registry_name
  resource_group_name = local.resource_group_name
  location            = local.location
  sku                 = "Basic"
  admin_enabled       = false
  # georeplications {
  #   location                = "East US"
  #   zone_redundancy_enabled = true
  #   tags                    = {}
  # }
  # georeplications {
  #   location                = "westeurope"
  #   zone_redundancy_enabled = true
  #   tags                    = {}
  # }
}
