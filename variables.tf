variable "resource_group_name" {
 description = "The name of the resource group in which the resources will be created"
 default     = "RGaimplutusTEST-Terraform"
}

variable "location" {
 description = "The location where resources will be created"
 default = "West US 2"
}

variable "tags" {
 description = "A map of the tags to use for the resources that are deployed"
 type        = "map"

 default = {
   environment = "TESTDR"
 }
}

variable "WEBSITES_APP_SERVICE_STORAGE" {
 description = ""
 default = "false"
}


variable "storageaccountname" {
 description = "storage for terraform tf state"
 default = "teststorageaccterraform"
}

variable "docker_ACR_url" {
 description = "docker url"
 type = "string"
}

variable "docker_ACR_username" {
 description = " username"
  type = "string"
 }

variable "docker_ACR_password" {
 description = " password"
  type = "string"
}
variable "ACR_Repo_path" {
 description = " Repository details in the ACR "
  type = "string"
}
variable "server_name" {
  default = "sql-servertest"
  description = "server name"
}
variable "server_password" {
  default ="H@Sh1CoR3!"
  description = "server password"
}
variable "server_username" {
  default = "mysqladminun"
  description = "login id"
}
variable "database_name" {
  default = "sql-db19"
  description = "login id"
}
variable "prefix" {
  description = "The Prefix used for all resources in this example"
  default = "aimleTEST"
}
variable "appplanname" {
  description = "app-plan-name"
  default = "app-plan-aimle-dev-TEST"
}
variable "appname" {
  description = "app-name"
  default = "app-aimle-dev-TEST"
}
variable "dls" {
  description = "data lake store name"
  default = "dlsaimledevtest"
}
variable "dlsfwrule" {
  description = "data lake store firewall name"
  default = "dlsfwruleaimledevtest"
}
variable "dla" {
  description = "data lake analytics account name"
  default = "dlaaimledevtest"
}
variable "dlafwrule" {
  description = "data lake analytics firewall  name"
  default = "dlafwruleaimledevtest"
}
 