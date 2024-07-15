# master.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      #version = "~> 3.21" # Optional but recommended in production
    }
  }
}

# Incluir los archivos de la carpeta BE y hacer que dependa de la creación del módulo frontend
module "backend" {
  source     = "./BE"
}

# Incluir los archivos de la carpeta FE
module "frontend" {
  source = "./FE"
  depends_on = [module.backend]
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}
