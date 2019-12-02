provider "azurerm" {
  version = "~>1.25"
  subscription_id = "1d021829-09c2-47de-9160-f9597e6f66ad"
  client_id       = "2ff773c2-cfa8-49d3-b007-39a118bf0c6e"
  client_secret   = "cd584b10-cc33-496d-8d93-dfc485f3b2da"
  tenant_id       = "6e06e42d-6925-47c6-b9e7-9581c7ca302a"
}

terraform {
  required_version = ">=  0.12.0"
}
