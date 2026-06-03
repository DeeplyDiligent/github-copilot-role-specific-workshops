// Configure the Azure provider
provider "azurerm" {
  features {}
}

// Resource Group
resource "azurerm_resource_group" "python_app_rg" {
  name     = var.resource_group_name
  location = var.location
}

// App Service Plan
resource "azurerm_app_service_plan" "python_app_plan" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.python_app_rg.location
  resource_group_name = azurerm_resource_group.python_app_rg.name
  kind                = "Linux"
  reserved            = true
  sku {
    tier = "Basic"
    size = "B1"
  }
}

// Application Insights
resource "azurerm_application_insights" "python_app_ai" {
  name                = "${var.app_service_name}-ai"
  location            = azurerm_resource_group.python_app_rg.location
  resource_group_name = azurerm_resource_group.python_app_rg.name
  application_type    = "web"
}

// Storage Account for QR codes
resource "azurerm_storage_account" "qr_codes_sa" {
  name                     = lower(replace("${var.app_service_name}qr", "-", ""))
  resource_group_name      = azurerm_resource_group.python_app_rg.name
  location                 = azurerm_resource_group.python_app_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
}

resource "azurerm_storage_container" "qr_codes" {
  name                  = "qrcodes"
  storage_account_name  = azurerm_storage_account.qr_codes_sa.name
  container_access_type = "private"
}

// App Service for Python
resource "azurerm_app_service" "python_app" {
  name                = var.app_service_name
  location            = azurerm_resource_group.python_app_rg.location
  resource_group_name = azurerm_resource_group.python_app_rg.name
  app_service_plan_id = azurerm_app_service_plan.python_app_plan.id
  site_config {
    linux_fx_version = "PYTHON|3.11"
    application_insights_key = azurerm_application_insights.python_app_ai.instrumentation_key
  }
  app_settings = {
    SCM_DO_BUILD_DURING_DEPLOYMENT = "true"
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.python_app_ai.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.python_app_ai.connection_string
    QR_CODES_STORAGE_ACCOUNT = azurerm_storage_account.qr_codes_sa.name
    QR_CODES_CONTAINER = azurerm_storage_container.qr_codes.name
    QR_CODES_STORAGE_CONNECTION_STRING = azurerm_storage_account.qr_codes_sa.primary_connection_string
  }
  depends_on = [
    azurerm_application_insights.python_app_ai,
    azurerm_storage_account.qr_codes_sa,
    azurerm_storage_container.qr_codes
  ]
}
