# Defines the minimum Terraform version required for this configuration.
terraform {
  required_version = ">= 1.6.0"

  # Declares the providers Terraform needs.
  required_providers {
    azurerm = {
      # Official Azure Resource Manager provider maintained by HashiCorp.
      source  = "hashicorp/azurerm"

      # Allows compatible versions within the 4.x release line.
      version = "~> 4.0"
    }
  }
}

# Configures Terraform to manage Microsoft Azure resources.
provider "azurerm" {
  # Required provider block. Additional provider features can be configured here.
  features {}
}