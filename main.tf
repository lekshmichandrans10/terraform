resource "azurerm_resource_group" "aci_rg" {
  name     = var.resource_group_name
  location = var.location
  tags = var.tags
}

resource "azurerm_storage_account" "stacc" {
  name                     = var.storageaccountname
  resource_group_name      = azurerm_resource_group.aci_rg.name
  location                 = azurerm_resource_group.aci_rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = var.tags
  }
}

terraform {
  backend "azurerm" {
    storage_account_name = "teststorageaccterraform"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"

  }
}

resource "azurerm_app_service_plan" "appserviceplan" {
  name                = var.appplanname
  location            = azurerm_resource_group.aci_rg.location
  resource_group_name = azurerm_resource_group.aci_rg.name
  kind =   "Linux"
  reserved            = true 
  sku {
    tier = "Standard"
    size = "S1"
  }
  tags = var.tags
}
resource "azurerm_app_service" "dockerapp" {
  name                = var.appname
  location            = azurerm_resource_group.aci_rg.location
  resource_group_name = azurerm_resource_group.aci_rg.name
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id

   app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = var.WEBSITES_APP_SERVICE_STORAGE
    DOCKER_REGISTRY_SERVER_URL = var.docker_ACR_url
    DOCKER_REGISTRY_SERVER_USERNAME= var.docker_ACR_username
    DOCKER_REGISTRY_SERVER_PASSWORD = var.docker_ACR_password  
  }  
  site_config {
    linux_fx_version = var.ACR_Repo_path
    always_on        = "true"
  }
  identity {
    type = "SystemAssigned"
  }
  tags = var.tags
}

resource "azurerm_sql_server" "sqlserver" {
  name                = var.server_name
  location            = azurerm_resource_group.aci_rg.location
  resource_group_name = azurerm_resource_group.aci_rg.name
  version                      = "12.0"
  administrator_login          = var.server_username
  administrator_login_password = var.server_password
}

resource "azurerm_sql_database" "sqldb" {
  name                =  var.database_name
  resource_group_name =  azurerm_resource_group.aci_rg.name
  server_name         =  azurerm_sql_server.sqlserver.name
  location            =  azurerm_resource_group.aci_rg.location
  

  tags = var.tags
}

locals {
  datalake_location = "Central us"
}
 
resource "azurerm_data_lake_store" "datalakestore" {
  name                = var.dls
  resource_group_name = azurerm_resource_group.aci_rg.name
  location            = local.datalake_location
  tier                = "Consumption"
  tags = var.tags

}

resource "azurerm_data_lake_store_firewall_rule" "datalakestorefirewall" {
  name                = var.dlsfwrule
  account_name        = azurerm_data_lake_store.datalakestore.name
  resource_group_name = azurerm_resource_group.aci_rg.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
  

}

resource "azurerm_data_lake_analytics_account" "datalakeanalyticsacc" {
  name                       = var.dla
  resource_group_name        = azurerm_resource_group.aci_rg.name
  location                   = local.datalake_location
  tier                       = "Consumption"
  default_store_account_name = azurerm_data_lake_store.datalakestore.name
  tags = var.tags
}

resource "azurerm_data_lake_analytics_firewall_rule" "datalakeanalyticsaccfirewall" {
  name                = var.dlafwrule
  account_name        = azurerm_data_lake_analytics_account.datalakeanalyticsacc.name
  resource_group_name = azurerm_resource_group.aci_rg.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
  
}
