variable "product" {
  description = "Product name"
  type        = string
  default     = "Localiza-DevOps"
}

variable "team" {
  description = "Team name"
  type        = string
  default     = "infra"
}

variable "environment" {
  description = "Environment (dev, prod, etc.)"
  type        = string
  default     = "prod"
}

variable "ticket" {
  description = "Ticket ID"
  type        = string
  default     = "SRE-1234"
}

variable "application" {
  description = "Application name"
  type        = string
  default     = "myapp"
}

variable "appid" {
  description = "Application ID"
  type        = string
  default     = "app-001"
}

variable "coststring" {
  description = "Cost center string"
  type        = string
  default     = "cost-center-01"
}

variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_a" {
  description = "CIDR da Subnet A"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_cidr_b" {
  description = "CIDR da Subnet B"
  type        = string
  default     = "10.0.2.0/24"
}

variable "availability_zone_a" {
  description = "Availability Zone A"
  type        = string
  default     = "us-east-1a"
}

variable "availability_zone_b" {
  description = "Availability Zone B"
  type        = string
  default     = "us-east-1b"
}