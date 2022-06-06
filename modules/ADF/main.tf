data "azurerm_resource_group" "ADF" {
  name     = var.resource_group_name
}

resource "azurerm_data_factory" "adf1" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
}