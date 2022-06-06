resource "azurerm_resource_group" "rg1" {
  name     = "my-Vnet-resources"
  location = "West Europe"
}

module "vnet" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
  subnet_names        = ["subnet1","subnet2","subnet3"]

  depends_on = [azurerm_resource_group.rg1]
}

##--------Create blob storage------####

resource "azurerm_resource_group" "rg2" {
  name     = "my-blob-resources"
  location = "West Europe"
}
 
module "blob" {
  source              = "./modules/blob"
  resource_group_name = azurerm_resource_group.rg2.name
  location               = "West Europe"
  storage_account_name   = "mystore30th"
  storage_container_name = "my-files"

  depends_on = [azurerm_resource_group.rg2]
}

#######################ADF
resource "azurerm_resource_group" "rg3" {
  name     = "my-adf-resources"
  location = "West Europe"
}

module "ADF" {
  source              = "./modules/ADF"
  name                = "myadf1"
  resource_group_name = azurerm_resource_group.rg3.name
  location               = azurerm_resource_group.rg3.location

  depends_on = [azurerm_resource_group.rg3]
}
