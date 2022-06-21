

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

##########ADB
# data "external" "me" {
#   program = ["az", "account", "show", "--query", "user"]
# }

# locals {
#    tags = {
#      Environment = "Demo"
#    Owner       = lookup(data.external.me.result, "name")
#   }
# }
 

#############
resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 6
}
#######################ADF


# resource "azurerm_resource_group" "rg3" {
#   name     ="${var.group_name}${lower(random_string.naming.result)}"
#   location =var.group_location
  
# }

module "ADF" {
  source              = "./modules/ADF"
  name_adf            = "${var.adf_Prefix}${random_string.naming.result}"
  resource_group      = var.rg_name ##azurerm_resource_group.rg3.name
  location_name       = var.rg_location ##azurerm_resource_group.rg3.location
 ## depends_on          = [azurerm_resource_group.rg3]
}

 

############ADB

module "ADB" {
  source                          = "./modules/ADB"
  adb_name                        = "${var.adb_Prefix}${random_string.naming.result}"
  adb_resource_group_name         = var.rg_name ##azurerm_resource_group.rg3.name
  adb_location                    = var.rg_location
  adb_managed_resource_group_name ="${var.adb_managedRecoucegroup}${random_string.naming.result}"
   
 ## depends_on          = [azurerm_resource_group.rg3]
}
