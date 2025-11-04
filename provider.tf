#-------------------------------#
# Configuração do provedor AWS
#-------------------------------#

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws" # Provedor oficial AWS
      version = "~> 5.0"        # Garante compatibilidade estável com a versão 5.x
    }
  }

  required_version = ">= 1.6.0" # Versão mínima do Terraform compatível
}

provider "aws" {
  region = var.aws_region # Região da AWS definida em variables.tf
}
