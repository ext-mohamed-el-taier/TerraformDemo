/*
 * # Resource Group Module
 *
 * This module creates an empty Resource Group.
 */
terraform {
  required_version = "~> 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}



resource "azurerm_resource_group" "rg" {
  name     = var.resourceGroupName
  location = var.location
  tags     = var.tags
}
