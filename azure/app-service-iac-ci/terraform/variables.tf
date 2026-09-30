# Existing Pluralsight sandbox Resource Group.
variable "resource_group_name" {
  description = "Name of the existing Azure Resource Group."
  type        = string
  default     = "1-5b95602c-playground-sandbox"
}

# Azure region used for deployed resources.
variable "location" {
  description = "Azure region for the App Service resources."
  type        = string
  default     = "westus"
}

# Name of the Azure App Service Plan.
variable "app_service_plan_name" {
  description = "Name of the Azure App Service Plan."
  type        = string
  default     = "asp-cloud-dev-day01-tf"
}

# Web App names must be globally unique in Azure.
variable "web_app_name" {
  description = "Globally unique name for the Azure Web App."
  type        = string
  default     = "liam-cloud-dev-day01-tf-webapp"
}