resource "azurerm_public_ip" "azurePublicIp" {
  name                = local.public_ip_name
  location            = local.location
  resource_group_name = local.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}




resource "azurerm_application_gateway" "network" {
  name                = local.load_balancer_name
  resource_group_name = local.resource_group_name
  location            = local.location



  sku {
    name = "Standard_v2"
    tier = "Standard_v2"
    #capacity = 1
  }

  gateway_ip_configuration {
    name      = "cicd-application-gateway-conf"
    subnet_id = azurerm_subnet.frontend.id
  }


  probe {
    name                                      = "healthProbe"
    pick_host_name_from_backend_http_settings = true
    port                                      = 80
    interval                                  = 60
    path                                      = "/"
    timeout                                   = 200
    protocol                                  = "Http"
  }


  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.azurePublicIp.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                                = local.http_setting_name
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 80
    protocol                            = "Http"
    request_timeout                     = 60
    probe_name                          = "healthProbe"
    pick_host_name_from_backend_address = true
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }

  autoscale_configuration {
    max_capacity = 2
    min_capacity = 1
  }

  depends_on = [
    azurerm_resource_group.azureResourceGroup,
    azurerm_subnet.backend,
    azurerm_subnet.frontend
  ]
}










