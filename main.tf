
# Arquivo principal do projeto Terraform AWS
# Responsável por orquestrar os recursos definidos em arquivos separados.

#-------------------------------#
# VPC e componentes de rede
#-------------------------------#
module "network" {
  source = "./vpc"  # Diretório que conterá vpc.tf e seus recursos
}

#-------------------------------#
# Instâncias EC2
#-------------------------------#
module "ec2_instances" {
  source         = "./ec2"
  vpc_id         = module.network.vpc_id
  public_subnet  = module.network.public_subnets[0]
  private_subnet = module.network.private_subnets[0]
  key_name       = var.key_name
  my_ip          = var.my_ip
  instance_type  = var.instance_type
}

#-------------------------------#
# Bucket S3
#-------------------------------#
module "s3_storage" {
  source       = "./s3"
  project_name = var.project_name
  environment  = var.environment
}

