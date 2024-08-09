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