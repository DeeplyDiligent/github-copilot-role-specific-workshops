// outputs.tf
output "app_service_default_site_hostname" {
  description = "The default hostname of the App Service."
  value       = azurerm_app_service.python_app.default_site_hostname
}

output "resource_group_name" {
  description = "The name of the resource group."
  value       = azurerm_resource_group.python_app_rg.name
}
