#-------------------------------#
# Arquivo principal do projeto
#-------------------------------#
# Função: orquestrar os módulos (VPC, EC2, S3)
# Não cria recursos diretos da AWS — apenas invoca módulos.
#-------------------------------#

#-------------------------------#
# Módulo VPC
#-------------------------------#
module "vpc" {
  source                = "./modules/vpc" # Caminho do módulo
  project_name          = var.project_name
  environment           = var.environment
  aws_region            = var.aws_region
  vpc_cidr              = var.vpc_cidr
  public_subnets_cidrs  = var.public_subnets_cidrs
  private_subnets_cidrs = var.private_subnets_cidrs
}

#-------------------------------#
# Módulo EC2
#-------------------------------#
module "ec2" {
  source         = "./modules/ec2"
  project_name   = var.project_name
  environment    = var.environment
  vpc_id         = module.vpc.vpc_id
  public_subnet  = module.vpc.public_subnets[0]
  private_subnet = module.vpc.private_subnets[0]
  key_name       = var.key_name
  instance_type  = var.instance_type
  my_ip          = var.my_ip
  ami_id         = var.ami_id
}

#-------------------------------#
# Módulo S3
#-------------------------------#
module "s3" {
  source       = "./modules/s3"
  project_name = var.project_name
  environment  = var.environment
}

