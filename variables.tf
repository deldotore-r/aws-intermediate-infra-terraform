#-------------------------------#
# Variáveis globais do projeto
#-------------------------------#
# Estas variáveis são repassadas para os módulos
# e centralizam parâmetros comuns (região, nomes, tipos, etc.)
#-------------------------------#

variable "project_name" {
  description = "Nome base do projeto"
  type        = string
}

variable "environment" {
  description = "Ambiente (ex: dev, prod)"
  type        = string
}

variable "aws_region" {
  description = "Região AWS onde os recursos serão criados"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR principal da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidrs" {
  description = "CIDRs das subnets públicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets_cidrs" {
  description = "CIDRs das subnets privadas"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "key_name" {
  description = "Nome da key pair existente na AWS (SSH)"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI utilizada para instâncias EC2"
  type        = string
}

variable "my_ip" {
  description = "IP público do usuário no formato x.x.x.x/32 (para acesso SSH)"
  type        = string
}
