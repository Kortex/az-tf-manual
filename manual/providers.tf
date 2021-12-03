provider "azurerm" {
  subscription_id = local.subscription_id
  features {}
}

provider "azuread" {}

provider "github" {
  owner = local.github.org_name
  token = var.github_pat
}
