#-------------------------------#
# Bucket S3 para armazenamento
#-------------------------------#

# ID aleatório para evitar conflito de nomes globais
resource "random_id" "suffix" {
  byte_length = 4
}

# Cria o bucket S3
resource "aws_s3_bucket" "main" {
  bucket = "${var.project_name}-${var.environment}-${random_id.suffix.hex}"
  tags = {
    Name = "${var.project_name}-${var.environment}-bucket"
  }
}
