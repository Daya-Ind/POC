# data "azurerm_resource_group" "ADF" {
#   name     = var.resource_group_name
# }

resource "azurerm_data_factory" "adf1" {
  name                = var.name_adf
  location            = var.location_name
  resource_group_name = var.resource_group
}