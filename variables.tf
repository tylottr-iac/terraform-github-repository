#################################
# Basic Repository Configuration
#################################

variable "name" {
  description = "Name of the repository."
  type        = string
}

variable "description" {
  description = "Description of the repository."
  type        = string
  default     = null
}

variable "homepage_url" {
  description = "Homeage URL of the repository."
  type        = string
  default     = null
}

variable "visibility" {
  description = "Controls the visibility of the repository."
  type        = string
  default     = "private"
}

variable "auto_init" {
  description = "If true, produce an initial commit on repository creation."
  type        = bool
  default     = true
}

variable "topics" {
  description = "Topics to add to the repository."
  type        = list(string)
  default     = []
}

variable "archive_on_destroy" {
  description = "If true, archive repository instead of destroying it with Terraform."
  type        = bool
  default     = false
}

variable "gitignore_template" {
  description = "Template for .gitignore. Use the name without the extension from here: https://github.com/github/gitignore"
  type        = string
  default     = null
}

variable "license_template" {
  description = "Template for the repository license. Use the name without the extension from here: https://github.com/github/choosealicense.com/tree/gh-pages/_licenses"
  type        = string
  default     = null
}

variable "template" {
  description = "The repository to use as a template in owner/repository format."
  type        = string
  default     = null
}

variable "default_branch" {
  description = "Default branch of the repository."
  type        = string
  default     = "main"
}

######################
# Repository Features
######################

variable "is_template" {
  description = "Set to true if this repository is used as a template."
  type        = bool
  default     = false
}

variable "has_issues" {
  description = "Has Issues feature activated."
  type        = bool
  default     = false
}

variable "has_projects" {
  description = "Has Projects feature activated."
  type        = bool
  default     = false
}

variable "has_wiki" {
  description = "Has Wiki feature activated."
  type        = bool
  default     = false
}

variable "has_discussions" {
  description = "Has Discussions feature activated."
  type        = bool
  default     = false
}

variable "vunlerability_alerts" {
  description = "Has Vulnerability Alerts feature activated."
  type        = bool
  default     = null
}

variable "pages_branch" {
  description = "Branch to use for Github Pages site."
  type        = string
  default     = null
}

variable "pages_path" {
  description = "Path to use for Github Pages site."
  type        = string
  default     = "/"
}

variable "pages_cname" {
  description = "Custom domain to use for Github Pages site. (Only works after repository has been created)"
  type        = string
  default     = null
}

##############
# Permissions
##############

variable "collaborators" {
  description = "Map of objects containing collaborators and their permissions where the username is the key. Valid permissions are pull, push, triage, maintain and admin."
  type = map(
    object({
      permission       = optional(string)
      diff_suppression = optional(bool)
    })
  )
  default = {}
}

variable "teams" {
  description = "Map of objects containing teams and their permissions where the team id is the key. Valid permissions are pull, push, triage, maintain and admin."
  type = map(
    object({
      permission = optional(string)
    })
  )
  default = {}
}

##############
# Deploy Keys
##############

variable "deploy_keys" {
  description = "Map of objects containing deploy keys and their read_only status where the name is the key."
  type = map(
    object({
      public_key = string
      read_only  = optional(bool, true)
    })
  )
  default = {}
}

###########
# Webhooks
###########

variable "webhooks" {
  description = "Map of objects containing webhooks and their configuration where the url is the key. See github_repository_webhook documentation for more."
  type = map(
    object({
      active       = optional(bool, true)
      events       = list(string)
      content_type = optional(string, "json")
      insecure_ssl = optional(bool, false)
      secret       = optional(string)
    })
  )
  default = {}
}

###############
# Issue Labels
###############

variable "issue_labels" {
  description = "Map of objects containing issue labels where the name is the key. Color is in hex format without leading #."
  type = map(
    object({
      color       = optional(string, "00FF00")
      description = optional(string)
    })
  )
  default = {}
}

###########
# Projects
###########

variable "projects" {
  description = "Map of objects containing projects where the name is the key."
  type = map(
    object({
      body = optional(string)
    })
  )
  default = {}
}
