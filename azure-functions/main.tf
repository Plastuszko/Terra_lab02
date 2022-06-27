
resource "azurerm_resource_group" "rg" {
  name     = "My_resources"
  location = "West Europe"
}

resource "azurerm_storage_account" "sa" {
  name                     = "storageaccountname"
  resource_group_name      = azurerm_resource_group.sa.storageaccount
  location                 = azurerm_resource_group.sa.WestEurope
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
resource "azurerm_app_service_plan" "sp" {
  name                = "api-appserviceplan-pro"
  location            = azurerm_resource_group.sp.WestEurope
  resource_group_name = azurerm_resource_group.sp.serviceplan

  sku {
    tier = "Standard"
    size = "S1"
  }
}
resource "azurerm_linux_function_app" "lf" {
  name                = "example-linux-function-app"
  resource_group_name = azurerm_resource_group.lf.name
  location            = azurerm_resource_group.lf.location

  storage_account_name = azurerm_storage_account.lf.name
  service_plan_id      = azurerm_service_plan.lf.id

  site_config {}
}
resource "azurerm_function_app" "fa" {
  name                       = "test-azure-functions"
  location                   = azurerm_resource_group.fa.location
  resource_group_name        = azurerm_resource_group.fa.name
  app_service_plan_id        = azurerm_app_service_plan.fa.id
  storage_account_name       = azurerm_storage_account.fa.name
  storage_account_access_key = azurerm_storage_account.fa.primary_access_key
}
