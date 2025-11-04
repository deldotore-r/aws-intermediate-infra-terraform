#-------------------------------#
# Saídas principais do projeto
#-------------------------------#
# Expõem informações úteis após o apply:
# IDs, IPs e nomes de recursos.
#-------------------------------#

output "vpc_id" {
  description = "ID da VPC criada"
  value       = module.vpc.vpc_id
}

output "bastion_public_ip" {
  description = "IP público da instância Bastion"
  value       = module.ec2.bastion_public_ip
}

output "app_private_ip" {
  description = "IP privado da instância App"
  value       = module.ec2.app_private_ip
}

output "bucket_name" {
  description = "Nome do bucket S3 criado"
  value       = module.s3.bucket_name
}
