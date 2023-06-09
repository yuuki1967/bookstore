variable "azure_credentials" {
  type        = string
  sensitive   = true
  description = "Azure credentials as a JSON object containing subscriptionId, tenantId, clientId and secretId"
}

variable "azure_context" {
  type = object({
    location = optional(string)
    service_plan = optional(object({
      tier = optional(string)
      size = optional(string)
    }))
  })
}

variable "azure_resource_suffix" {
  type        = string
  description = "Suffix for Resources created in Azure"
}
