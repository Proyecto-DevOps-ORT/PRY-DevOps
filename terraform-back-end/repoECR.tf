# 3 creacion repo ecr
# "repo-shipping" = nombre del recurso (interno en terraform)
resource "aws_ecr_repository" "repo-shipping"{
    # "repo-pry-backend-shipping" = nombre del repositorio en AWS
    name = "repo-pry-backend-shipping"
    #Establecer image_tag_mutability a MUTABLE significa que las etiquetas de las imágenes 
    #en este repositorio pueden cambiarse después de que la imagen haya sido subida.
    image_tag_mutability = "MUTABLE"

    image_scanning_configuration {
        scan_on_push = true
    }
}