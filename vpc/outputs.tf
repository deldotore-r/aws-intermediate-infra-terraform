#-------------------------------#
# Saídas do módulo VPC
#-------------------------------#

# ID da VPC criada
output "vpc_id" {
  description = "ID da VPC criada."
  value       = aws_vpc.this.id
}

# Lista de subnets públicas
output "public_subnets" {
  description = "Lista de subnets públicas criadas."
  value       = [for s in aws_subnet.public : s.id]
}

# Lista de subnets privadas
output "private_subnets" {
  description = "Lista de subnets privadas criadas."
  value       = [for s in aws_subnet.private : s.id]
}

# ID do NAT Gateway
output "nat_gateway_id" {
  description = "ID do NAT Gateway criado."
  value       = aws_nat_gateway.this.id
}

# ID do Internet Gateway
output "internet_gateway_id" {
  description = "ID do Internet Gateway criado."
  value       = aws_internet_gateway.this.id
}
