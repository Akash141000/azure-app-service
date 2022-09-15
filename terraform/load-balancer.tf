resource "azurerm_public_ip" "azurePublicIp" {
  name                = local.public_ip_name
  location            = local.location
  resource_group_name = local.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_lb" "azureLoadBalancer" {
  name                = local.load_balancer_name
  location            = local.location
  resource_group_name = local.resource_group_name
  frontend_ip_configuration {
    name                 = local.fontend_public_ip_name
    public_ip_address_id = azurerm_public_ip.azurePublicIp.id
  }
}

resource "azurerm_lb_backend_address_pool" "azureBackendAddressPool" {
  resource_group_name = local.resource_group_name
  loadbalancer_id     = azurerm_lb.azureLoadBalancer.id
  name                = "backendPool"
}


resource "azurerm_lb_nat_rule" "azureNatRule" {
  resource_group_name            = local.resource_group_name
  loadbalancer_id                = azurerm_lb.azureLoadBalancer.id
  name                           = "HTTP Access"
  protocol                       = "Tcp"
  frontend_port                  = 3000
  backend_port                   = 3000
  frontend_ip_configuration_name = local.fontend_public_ip_name
  backend_address_pool_id        = azurerm_lb_backend_address_pool.azureBackendAddressPool.id
}

