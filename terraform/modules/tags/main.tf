variable "product" {
  description = "Product name"
  type        = string
}

variable "team" {
  description = "Team name"
  type        = string
}

variable "environment" {
  description = "Environment (dev, prod, etc.)"
  type        = string
}

variable "ticket" {
  description = "Ticket ID"
  type        = string
}

variable "application" {
  description = "Application name"
  type        = string
}

variable "appid" {
  description = "Application ID"
  type        = string
}

variable "coststring" {
  description = "Cost center string"
  type        = string
}

locals {
  name = "${var.team}-${var.application}-${var.environment}"

  common_tags = {
    Name         = local.name
    Product      = var.product
    Team         = var.team
    Environment  = var.environment
    Ticket       = var.ticket
    Application  = var.application
    AppID        = var.appid
    CostString   = var.coststring
  }
}

output "tags" {
  value = local.common_tags
}