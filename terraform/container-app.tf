resource "azapi_resource" "azureContainerAppEnv" {
  type      = "Microsoft.App/managedEnvironments@2022-03-01"
  parent_id = azurerm_resource_group.azureResourceGroup.id
  location  = local.location
  name      = "cicdContainerAppEnv"

  body = jsonencode({
    properties = {
      appLogsConfiguration = {
        destination = "log-analytics"
        logAnalyticsConfiguration = {
          customerId = azurerm_log_analytics_workspace.log.workspace_id
          sharedKey  = azurerm_log_analytics_workspace.log.primary_shared_key
        }
      }
      vnetConfiguration = {
        infrastructureSubnetId = azurerm_subnet.containerEnv.id
        runtimeSubnetId        = azurerm_subnet.backend.id
      }
    }
  })
  depends_on = [
    azurerm_resource_group.azureResourceGroup
  ]
}


resource "azapi_resource" "azureContainerApp" {
  for_each  = { for ca in var.container_apps : ca.name => ca }
  type      = "Microsoft.App/containerApps@2022-03-01"
  parent_id = azurerm_resource_group.azureResourceGroup.id
  location  = local.location
  name      = "cicd-container-app"
  identity {
    type = "SystemAssigned"
  }


  body = jsonencode({
    properties : {
      managedEnvironmentId = azapi_resource.azureContainerAppEnv.id
      configuration = {
        ingress = {
          external   = each.value.ingress_enabled
          targetPort = each.value.ingress_enabled ? each.value.containerPort : null
        }
      }
      template = {
        containers = [
          {
            name  = each.value.name
            image = "nginx"
            resources = {
              cpu    = each.value.cpu_requests
              memory = each.value.mem_requests
            }

          }
        ]
        scale = {
          minReplicas = each.value.min_replicas
          maxReplicas = each.value.max_replicas
        }
      }
    }
  })

  depends_on = [
    azurerm_resource_group.azureResourceGroup
  ]
}
