resource "azurerm_log_analytics_workspace" "log" {
  name                = "cicdlogging"
  resource_group_name = local.resource_group_name
  location            = local.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
