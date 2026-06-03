// variables.tf
variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "python-app-rg"
}

variable "location" {
  description = "The Azure region to deploy resources in."
  type        = string
  default     = "australiaeast"
}

variable "app_service_plan_name" {
  description = "The name of the App Service plan."
  type        = string
  default     = "python-app-service-plan"
}

variable "app_service_name" {
  description = "The name of the App Service."
  type        = string
  default     = "python-app-service"
}
