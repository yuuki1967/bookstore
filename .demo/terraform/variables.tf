variable "github_token" {
  type        = string
  sensitive   = true
  description = "GitHub Personal Access Token with Repository and Packages Access"
}

variable "github_context" {
  type = object({
    actor = string

    template_repository = object({
      owner = string
      repo  = string
    })

    target_repository = object({
      owner = string
      repo  = string
    })

    project = optional(object({
      create = bool
    }))
  })
}

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