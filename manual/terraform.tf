terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.88.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.12.0"
    }
    github = {
      source  = "integrations/github"
      version = "4.18.2"
    }
  }
  required_version = ">=1.0.11"
}