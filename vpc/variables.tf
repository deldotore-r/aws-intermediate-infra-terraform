#-------------------------------#
# Variáveis do módulo VPC
#-------------------------------#

# Nome base do projeto, usado para tags e nomes de recursos
variable "project_name" {
  description = "Nome base do projeto para tags."
  type        = string
}

# Ambiente de implantação (ex: dev, prod) para tagueamento
variable "environment" {
  description = "Ambiente (ex: dev, prod) para tags."
  type        = string
}

# Região AWS onde a VPC será criada
variable "aws_region" {
  description = "Região AWS onde a VPC será criada."
  type        = string
  default     = "us-east-1"
}

# Bloco CIDR principal da VPC
variable "vpc_cidr" {
  description = "CIDR da VPC."
  type        = string
  default     = "10.0.0.0/16"
}

# Lista de CIDRs para subnets públicas
variable "public_subnets_cidrs" {
  description = "Lista de CIDRs para subnets públicas."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# Lista de CIDRs para subnets privadas
variable "private_subnets_cidrs" {
  description = "Lista de CIDRs para subnets privadas."
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}
