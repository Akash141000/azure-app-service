
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  # backend "azurerm" {
  #   resource_group_name  = "tfstate-cicd-testing"
  #   storage_account_name = "cicdresourcegroup"
  #   container_name       = "cicdterraformcontainer"
  #   key                  = "terraform.tfstate"
  # }
}

provider "azurerm" {
  features {

  }
  tenant_id       = ""
  subscription_id = ""
  client_id       = ""
  client_secret   = ""
}
