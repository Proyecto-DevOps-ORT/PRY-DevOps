# VPC Configuration
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "ecs-vpc-backend"
  }
}

# Subnets Configuration

resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
    tags = {
        Name = "ecs-subnet1-public"
    }
}

resource "aws_subnet" "subnet2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
    tags = {
        Name = "ecs-subnet2-public"
    }
}

# Security Group Configuration

resource "aws_security_group" "security_group" {
    name = "ecs-security-group"
    vpc_id = aws_vpc.vpc.id
    # ingress {
    #     from_port = 0
    #     to_port = 0
    #     protocol = "-1"
    #     cidr_blocks = ["0.0.0.0/0"]  
    # }
    # ingress {
    #     description = "http"
    #     from_port = 8080
    #     to_port = 8080
    #     protocol = "TCP"
    #     cidr_blocks = ["0.0.0.0/0"]  
    # }

    ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# Internet Gateway Configuration
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "ecs-vpc-back-igw"
  }
}

# Route Table Configuration
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "ecs-route-table"
  }
}

# Route Configuration for Internet Gateway
resource "aws_route" "route" {
  route_table_id = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "subnet1_association" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subnet2_association" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.route_table.id
}

################# BALANCEADOR DE CARGA ############################

# # creo target group

# resource "aws_lb_target_group" "target_group_ort" {
#   name     = "target-group_devops"
#   port     = 8080
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.vpc.id
#   tags = {
#     Name = "tg-for-all-microservices"
#   }
#   # agrego healenhy_check 
#   health_check {
#     path                = "/health"
#     protocol            = "HTTP"
#     port                = "8080"
#     interval            = 30
#     timeout             = 5
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#   }
# }

# # crear balanceador de carga



# # creo 







################ Info  #################################################3

# cidr_block = "10.0.0.0/16"

#La longitud del prefijo (/16) indica que los primeros 16 bits de la dirección IP son fijos y 
#los 16 bits restantes son variables. Esto proporciona un rango de direcciones IP desde 10.0.0.0 hasta 10.0.255.255.
#En total, permite hasta 65,536 direcciones IP únicas.

 #cidr_block = "10.0.1.0/24"

 #La longitud del prefijo (/24) indica que los primeros 24 bits de la dirección IP son fijos y 
 #los 8 bits restantes son variables. Esto proporciona un rango de direcciones IP desde 10.0.1.0 hasta 10.0.1.255.
 #En total, permite hasta 256 direcciones IP únicas.


#Resumen

#CIDR Block de la VPC (10.0.0.0/16): Define un rango amplio de direcciones IP (65,536 direcciones) 
#que se pueden utilizar dentro de la VPC.

#CIDR Block de las Subnets (10.0.1.0/24, 10.0.2.0/24, 10.0.3.0/24): Dividen el rango más amplio de la VPC en
#rangos más pequeños (256 direcciones cada uno) que se asignan a diferentes subnets.


#Nota: Las direcciones IP se pueden representar en binario para comprender mejor cómo se dividen en prefijos de longitud variable.
#Por ejemplo, la dirección IP 192.168.1.1 se puede descomponer en binario como sigue:

#192 en binario: 11000000
#168 en binario: 10101000
#1 en binario: 00000001
#1 en binario: 00000001



# por que hay 251 ips disponibles en cada subnet?

# En una subred 10.0.1.0/24, tienes 251 direcciones IP disponibles para asignar a instancias y otros recursos.

# Resumen:
# 10.0.1.0: Dirección de red (no disponible)
# 10.0.1.1 - 10.0.1.3: Reservadas por AWS (no disponibles)
# 10.0.1.255: Dirección de broadcast (no disponible)
# Eso deja 251 direcciones IP (10.0.1.4 a 10.0.1.254) disponibles para uso en la subred.