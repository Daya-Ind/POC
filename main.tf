# resource "azurerm_resource_group" "rg1" {
#   name     = "my-Vnet-resources"
#   location = "West Europe"
# }

# module "vnet" {
#   source              = "./modules/vnet"
#   resource_group_name = azurerm_resource_group.rg1.name
#   address_space       = ["10.0.0.0/16"]
#   subnet_prefixes     = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
#   subnet_names        = ["subnet1","subnet2","subnet3"]

#   depends_on = [azurerm_resource_group.rg1]
# }

# ##--------Create blob storage------####

# resource "azurerm_resource_group" "rg2" {
#   name     = "my-blob-resources"
#   location = "West Europe"
# }
 
# module "blob" {
#   source              = "./modules/blob"
#   resource_group_name = azurerm_resource_group.rg2.name
#   location               = "West Europe"
#   storage_account_name   = "mystore30th"
#   storage_container_name = "my-files"

#   depends_on = [azurerm_resource_group.rg2]
# }


#######Naming
resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 6
}
#######################ADF


resource "azurerm_resource_group" "rg3" {
  name     ="${var.group_name}${lower(random_string.naming.result)}"
  location =var.group_location
}

module "ADF" {
  source              = "./modules/ADF"
  name_adf            = "${var.adf_Prefix}${random_string.naming.result}"
  resource_group      = azurerm_resource_group.rg3.name
  location_name       = azurerm_resource_group.rg3.location

  depends_on          = [azurerm_resource_group.rg3]
}

 

############ADB