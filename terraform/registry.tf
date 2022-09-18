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

  depends_on = [
    azurerm_resource_group.azureResourceGroup

  ]
}

resource "azurerm_role_assignment" "acrPull" {
  for_each             = { for ca in var.container_apps : ca.name => ca }
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"

  principal_id = azapi_resource.azureContainerApp[each.key].identity[0].principal_id

  depends_on = [
    azurerm_container_registry.acr,
    azapi_resource.azureContainerApp
  ]
}
