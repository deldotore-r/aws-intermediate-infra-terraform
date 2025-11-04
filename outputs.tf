#-------------------------------#
# Saídas consolidadas
#-------------------------------#

output "bastion_public_ip" {
  description = "Endereço IP público da instância Bastion."
  value       = module.ec2_instances.bastion_public_ip
}

output "app_private_ip" {
  description = "Endereço IP privado da instância de aplicação."
  value       = module.ec2_instances.app_private_ip
}

output "s3_bucket_name" {
  description = "Nome do bucket S3 criado."
  value       = module.s3_storage.bucket_name
}
