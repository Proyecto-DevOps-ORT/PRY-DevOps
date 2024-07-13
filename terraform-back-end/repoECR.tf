######################################################################################################################################
###############     SHIPPING  ########################################################################################################

# 3 creacion repo ecr
# "repo-shipping" = nombre del recurso (interno en terraform)
resource "aws_ecr_repository" "repo-shipping"{
    # "repo-pry-backend-shipping" = nombre del repositorio en AWS
    name = "pry-backend-shipping"
    #Establecer image_tag_mutability a MUTABLE significa que las etiquetas de las imágenes 
    #en este repositorio pueden cambiarse después de que la imagen haya sido subida.
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}

######################################################################################################################################
###############     PRODUCTS  ########################################################################################################

resource "aws_ecr_repository" "repo-products"{
    # "repo-pry-backend-shipping" = nombre del repositorio en AWS
    name = "pry-backend-products"
    #Establecer image_tag_mutability a MUTABLE significa que las etiquetas de las imágenes 
    #en este repositorio pueden cambiarse después de que la imagen haya sido subida.
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}

######################################################################################################################################
###############     PAYMENTS  ########################################################################################################

resource "aws_ecr_repository" "repo-payments"{
    # "repo-pry-backend-shipping" = nombre del repositorio en AWS
    name = "pry-backend-payments"
    #Establecer image_tag_mutability a MUTABLE significa que las etiquetas de las imágenes 
    #en este repositorio pueden cambiarse después de que la imagen haya sido subida.
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}

######################################################################################################################################
###############     ORDERS  ########################################################################################################

resource "aws_ecr_repository" "repo-orders"{
    # "repo-pry-backend-shipping" = nombre del repositorio en AWS
    name = "pry-backend-orders"
    #Establecer image_tag_mutability a MUTABLE significa que las etiquetas de las imágenes 
    #en este repositorio pueden cambiarse después de que la imagen haya sido subida.
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}