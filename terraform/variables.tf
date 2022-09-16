locals {
  resource_group_name     = "cicd-resource-group"
  container_registry_name = "cicdtestingregistry"
  location                = "East US"
  web_app_name            = "cicd-web-app"
  load_balancer_name      = "cicdloadbalancerGateway"
  public_ip_name          = "cicdpublicip"
  fontend_public_ip_name  = "cicdpublicip"
  security_group_name     = "cicd-network-security-group"
  vnet                    = "cicdvnet"
}
