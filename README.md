# PRY-DevOps
Repositorio de proyecto final , optativa DevOps, Universidad ORT. 


## Back end

### Clonar proyecto

`
git clone git@github.com:Proyecto-DevOps-ORT/PRY-DevOps.git
`

### Crear rama de trabajo
`
git checkout -b feature/PDO-22
`

### Crear carpeta terraform-back-end

### Crear archivo config.tf

### crear .gitignore


### Vincular rama con repo origen
`
git add origin git@github.com:Proyecto-DevOps-ORT/PRY-DevOps.git
`


### Subir los cambios al repositorio de github
`
git push origin feature/PDO-22
`



## Info

por haber hecho terraform init ahora tube que quitar de seguimiento en git 

`
git rm -r --cached .terraform/
`
`
git rm --cached *.tfstate
`

Instalo plugins de terraform

`
terraform init
`

para verificar sintaxis de codigo terraform
`
terrafrm validate
`
Para ver lo que se va a correr 
`
terraform plan
`

<sup>Nota: Si parece quedar colgada la terminal es por que no estan cargadas las credenciales correctamente en el achivo home/.aws/credentials</sup>


para ejecutar codigo terraform

`
terraform apply
`

para eliminar todo lo que se creo con terraform

`
terraform destroy
`



