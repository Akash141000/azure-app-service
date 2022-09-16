
resource "azurerm_service_plan" "azureAppServicePlan" {
  name                = "example"
  resource_group_name = local.resource_group_name
  location            = local.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "azureLinuxWebApp" {
  name                = local.web_app_name
  resource_group_name = local.resource_group_name
  location            = local.location
  service_plan_id     = azurerm_service_plan.azureAppServicePlan.id

  site_config {}


  depends_on = [
    azurerm_service_plan.azureAppServicePlan
  ]
}


# resource "azurerm_app_service_source_control" "azureServiceSourceControl" {
#   app_id = azurerm_service_plan.azureAppServicePlan.id
#   depends_on = [
#     azurerm_linux_web_app.azureLinuxWebApp
#   ]

# }
