#-------------------------------#
# Criação da rede base (VPC)
#-------------------------------#

# Cria a VPC principal
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project_name}-${var.environment}-vpc"
  }
}

# Cria subnets públicas
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnets_cidrs[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-${var.environment}-public-${count.index + 1}"
  }
}

# Cria subnets privadas
resource "aws_subnet" "private" {
  count      = length(var.private_subnets_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnets_cidrs[count.index]
  tags = {
    Name = "${var.project_name}-${var.environment}-private-${count.index + 1}"
  }
}

# Cria o Internet Gateway (saída para a internet)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}-${var.environment}-igw"
  }
}

# Cria um Elastic IP para o NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# Cria o NAT Gateway (permite que subnets privadas acessem a internet)
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public[0].id
  tags = {
    Name = "${var.project_name}-${var.environment}-nat"
  }
}

# Tabela de rotas pública
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"                    # Todo tráfego sai pela internet
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Associação da tabela pública às subnets públicas
resource "aws_route_table_association" "public_assoc" {
  count          = length(var.public_subnets_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

# Tabela de rotas privada
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"               # Todo tráfego sai via NAT
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

# Associação da tabela privada às subnets privadas
resource "aws_route_table_association" "private_assoc" {
  count          = length(var.private_subnets_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_rt.id
}
