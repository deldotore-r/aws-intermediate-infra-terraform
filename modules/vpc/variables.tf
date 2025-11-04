# Variáveis específicas do módulo VPC
variable "project_name" {}
variable "environment" {}
variable "aws_region" {}
variable "vpc_cidr" {}
variable "public_subnets_cidrs" {
  type = list(string)
}
variable "private_subnets_cidrs" {
  type = list(string)
}
