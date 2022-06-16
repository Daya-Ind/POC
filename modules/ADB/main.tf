# terraform {
#   required_providers {
#     azurerm =  "~> 2.33"
#     random = "~> 2.2"
#   }
# }

# provider "azurerm" {
#   features {}
# }

# variable "region" {
#   type = string
#   default = "westus"
# }

# resource "random_string" "naming" {
#   special = false
#   upper   = false
#   length  = 6
# }

data "azurerm_client_config" "current" {
}

data "external" "me" {
  program = ["az", "account", "show", "--query", "user"]
}

locals {
  prefix = "shelltfpoc${random_string.naming.result}"
  tags = {
    Environment = "Demo"
    Owner       = lookup(data.external.me.result, "name")
  }
}

# resource "azurerm_resource_group" "this" {
#   name     = "${local.prefix}-rg"
#   location = var.region
#   tags     = local.tags
# }

# resource "azurerm_storage_account" "adbst" {
#   name                = "${local.prefix}st"
#   resource_group_name = azurerm_resource_group.this.name
#   location            = azurerm_resource_group.this.location
#   account_tier              = "Standard"
#   account_kind              = "StorageV2"
#   account_replication_type  = "LRS"
#   is_hns_enabled            = true
# }

resource "azurerm_databricks_workspace" "this" {
  name                        = var.name
  resource_group_name         = var.resource_group_name
  location                    = var.location
  sku                         = "premium"
  managed_resource_group_name = var.managed_resource_group_name
  tags                        = local.tags

 }

output "databricks_host" {
  value = "https://${azurerm_databricks_workspace.this.workspace_url}/"
}