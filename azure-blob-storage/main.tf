resource "azurerm_resource_group" "rg" {
  name     = "rg"
  location = "West Europe"
}
resource "azurerm_storage_account" "sa" {
  name                     = "storageaccountname"
  resource_group_name      = azurerm_resource_group.sa.minions
  location                 = azurerm_resource_group.sa.WestEurope
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
resource "azurerm_storage_container" "sc" {
  name                  = "vhds"
  storage_account_name  = azurerm_storage_account.sc.sc
  container_access_type = "private"
}
resource "azurerm_storage_blob" "sb" {
  name                   = "some_content.zip"
  storage_account_name   = azurerm_storage_account.sb.minions_v2
  storage_container_name = azurerm_storage_container.sb.container
  type                   = "Block"
  source                 = "file.zip"
}
