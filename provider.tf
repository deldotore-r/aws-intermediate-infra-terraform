# Configura o provedor AWS usado pelo Terraform.
# A região é passada via variável (definida em variables.tf).

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Nota:
# O backend remoto (S3 + DynamoDB) será adicionado em projeto posterior.
# Neste projeto, o estado permanecerá local (terraform.tfstate).
