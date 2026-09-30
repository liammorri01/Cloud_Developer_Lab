# Read the existing Resource Group instead of creating a new one.
data "azurerm_resource_group" "sandbox" {
  name = var.resource_group_name
}

# Create an Azure App Service Plan.
resource "azurerm_service_plan" "app_plan" {
  name                = var.app_service_plan_name
  resource_group_name = data.azurerm_resource_group.sandbox.name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "F1"
}

# Create an Azure Linux Web App using the App Service Plan.
resource "azurerm_linux_web_app" "web_app" {
  name                = var.web_app_name
  resource_group_name = data.azurerm_resource_group.sandbox.name
  location            = var.location
  service_plan_id     = azurerm_service_plan.app_plan.id

  site_config {
    always_on = false
  }
}