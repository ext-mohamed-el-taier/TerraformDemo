variable "location" {
  type        = string
  default     = "australiaeast"
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Set of base tags that will be applied to resource group."
}

variable "resourceGroupName" {
  type        = string
  default     = "rg-test"
  description = "Resource Group Name."
}
