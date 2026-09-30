# Returns the name of the App Service Plan created by Terraform.
output "app_service_plan_name" {
  description = "Name of the Azure App Service Plan."
  value       = azurerm_service_plan.app_plan.name
}

# Returns the name of the Web App created by Terraform.
output "web_app_name" {
  description = "Name of the Azure Web App."
  value       = azurerm_linux_web_app.web_app.name
}

# Returns the public hostname assigned to the Web App.
output "web_app_hostname" {
  description = "Default public hostname of the Azure Web App."
  value       = azurerm_linux_web_app.web_app.default_hostname
}