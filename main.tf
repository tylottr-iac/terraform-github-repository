#############
# Repository
#############

resource "github_repository" "main" {
  name         = var.name
  description  = var.description
  homepage_url = var.homepage_url

  visibility         = var.visibility
  auto_init          = var.auto_init
  archive_on_destroy = var.archive_on_destroy

  topics             = var.topics
  gitignore_template = var.gitignore_template
  license_template   = var.license_template

  vulnerability_alerts = var.vunlerability_alerts
  is_template          = var.is_template

  has_issues      = var.has_issues
  has_projects    = var.has_projects
  has_wiki        = var.has_wiki
  has_discussions = var.has_discussions

  dynamic "pages" {
    for_each = var.pages_branch != null ? [1] : []
    content {
      cname = var.pages_cname
      source {
        branch = var.pages_branch
        path   = var.pages_path
      }
    }
  }

  dynamic "template" {
    for_each = var.template == null ? [] : [1]
    content {
      # Split owner/repository from the var.template value[""]
      owner      = split("/", var.template)[0]
      repository = split("/", var.template)[1]
    }
  }
}

resource "github_branch_default" "main" {
  repository = github_repository.main.name
  branch     = var.default_branch
}

##############
# Permissions
##############

resource "github_repository_collaborator" "main" {
  for_each = var.collaborators

  repository = github_repository.main.name

  username   = each.key
  permission = each.value["permission"]
}

resource "github_team_repository" "main" {
  for_each = var.teams

  repository = github_repository.main.name

  team_id    = each.key
  permission = each.value["permission"]
}

##############
# Deploy Keys
##############

resource "github_repository_deploy_key" "main" {
  for_each = var.deploy_keys

  repository = github_repository.main.name

  title     = each.key
  key       = each.value["public_key"]
  read_only = each.value["read_only"]
}

###########
# Webhooks
###########

resource "github_repository_webhook" "main" {
  for_each = var.webhooks

  repository = github_repository.main.name

  active = each.value["active"]
  events = each.value["events"]

  configuration {
    url          = each.key
    content_type = each.value["content_type"]
    insecure_ssl = each.value["insecure_ssl"]
  }
}

###############
# Issue Labels
###############

resource "github_issue_label" "main" {
  for_each = var.issue_labels

  repository = github_repository.main.name

  name        = each.key
  color       = each.value["color"]
  description = each.value["description"]
}

###########
# Projects
###########

resource "github_repository_project" "project" {
  for_each = var.projects

  repository = github_repository.main.name

  name = each.key
  body = each.value["body"]
}
