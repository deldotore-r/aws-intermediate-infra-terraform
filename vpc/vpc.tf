#-------------------------------#
# VPC
#-------------------------------#
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true  # Necessário para resolução de DNS interno
  enable_dns_hostnames = true  # Permite que instâncias recebam nomes DNS
  tags = {
    Name        = "${var.project_name}-${var.environment}-vpc"
    Environment = var.environment
    Project     = var.project_name
  }
}

#-------------------------------#
# Internet Gateway
#-------------------------------#
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name        = "${var.project_name}-${var.environment}-igw"
    Environment = var.environment
    Project     = var.project_name
  }
}

#-------------------------------#
# Subnets Públicas
#-------------------------------#
resource "aws_subnet" "public" {
  for_each = toset(var.public_subnets_cidrs)
  vpc_id   = aws_vpc.this.id
  cidr_block = each.value
  map_public_ip_on_launch = true  # Garante IP público automático

  tags = {
    Name        = "${var.project_name}-${var.environment}-public-${replace(each.value,"/","-")}"
    Environment = var.environment
    Project     = var.project_name
  }
}

#-------------------------------#
# Subnets Privadas
#-------------------------------#
resource "aws_subnet" "private" {
  for_each = toset(var.private_subnets_cidrs)
  vpc_id   = aws_vpc.this.id
  cidr_block = each.value
  map_public_ip_on_launch = false  # Sem IP público

  tags = {
    Name        = "${var.project_name}-${var.environment}-private-${replace(each.value,"/","-")}"
    Environment = var.environment
    Project     = var.project_name
  }
}

#-------------------------------#
# NAT Gateway
#-------------------------------#
resource "aws_eip" "nat" {
  vpc = true  # Elastic IP para NAT
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id  # NAT precisa estar em subnet pública
}

#-------------------------------#
# Route Tables
#-------------------------------#
# Pública
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name        = "${var.project_name}-${var.environment}-public-rt"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_route_table_association" "public_assoc" {
  for_each = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# Privada
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }
  tags = {
    Name        = "${var.project_name}-${var.environment}-private-rt"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_route_table_association" "private_assoc" {
  for_each = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}
