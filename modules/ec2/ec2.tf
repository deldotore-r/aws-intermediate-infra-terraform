#-------------------------------#
# Instâncias EC2 (Bastion e App)
#-------------------------------#

# Security Group da Bastion (acesso público controlado por IP)
resource "aws_security_group" "bastion-sg" {
  name   = "${var.project_name}-${var.environment}-bastion-sg"
  vpc_id = var.vpc_id

 # Regra de entrada: permite SSH apenas do IP do usuário
  ingress {
    description = "SSH do IP do usuario"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  # Regra de saída: libera todo o tráfego de saída
  egress {
    description = "Saida liberada"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-bastion-sg"
  }
}

# Security Group da aplicação (acesso interno)
resource "aws_security_group" "app_sg" {
  name        = "${var.project_name}-${var.environment}-app-sg"
  description = "Security Group para instancias da aplicacao"
  vpc_id      = var.vpc_id

  # Permite SSH somente a partir do bastion host
  ingress {
    description     = "SSH permitido apenas da Bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion-sg.id]
  }

  # Libera trafego de saida
  egress {
    description = "Saida liberada"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-app-sg"
  }
}


# Instância Bastion (em subnet pública)
resource "aws_instance" "bastion" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet
  vpc_security_group_ids      = [aws_security_group.bastion-sg.id]
  associate_public_ip_address = true
  key_name                    = var.key_name
  tags = {
    Name = "${var.project_name}-${var.environment}-bastion"
  }
}

# Instância App (em subnet privada)
resource "aws_instance" "app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  key_name               = var.key_name
  tags = {
    Name = "${var.project_name}-${var.environment}-app"
  }
}
