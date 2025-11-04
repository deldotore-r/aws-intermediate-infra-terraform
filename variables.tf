
# Variáveis globais do projeto Terraform AWS

variable "aws_region" {
  description = "Região AWS onde os recursos serão criados."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nome base usado para tagueamento e identificação dos recursos."
  type        = string
  default     = "aws-intermediate-infra"
}

variable "environment" {
  description = "Ambiente de implantação (ex: dev, prod)."
  type        = string
  default     = "dev"
}

variable "instance_type" {
  description = "Tipo das instâncias EC2 utilizadas."
  type        = string
  default     = "t3.micro"
}

variable "my_ip" {
  description = "Endereço IP público do usuário para liberar acesso SSH (formato x.x.x.x/32)."
  type        = string
}

variable "key_name" {
  description = "Nome da chave SSH existente na AWS para acesso às instâncias."
  type        = string
}

# Nota:
# Variáveis sensíveis (como chaves) não devem ter valor padrão.
# Elas podem ser passadas via CLI, .tfvars ou variáveis de ambiente.
