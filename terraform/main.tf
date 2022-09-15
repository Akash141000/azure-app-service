
terraform {
  required_providers {
    name = {
      source = "azure"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate-cicd-testing"
    storage_account_name = "cicdresourcegroup"
    container_name       = "cicdterraformcontainer"
    key                  = "terraform.tfstate"
  }
}

provider "azure" {
  client_id     = ""
  client_secret = ""
}
