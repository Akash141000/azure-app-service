resource "azurerm_log_analytics_workspace" "log" {
  name                = "cicdlogging"
  resource_group_name = local.resource_group_name
  location            = local.location
  sku                 = "Free"
  retention_in_days   = 7
}
