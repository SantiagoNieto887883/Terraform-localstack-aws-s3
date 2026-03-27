# Infraestructura S3 PARA UNA APP EN PYTON

proyecto de s3 de manera modulada en AWS

---

# antes de iniciar

debes crear los archivos .tfvars en las rutas:

```bash
IAC/terraform/ENVIRONMENTS/<env>/backend.tfvars

IAC/terraform/ENVIRONMENTS/<env>/terraform.tfvars
```

-- contenido backend.tfvar--

```bash
#autenticación
profile = "tu perfil"

#use localstack
use_localstack = true #(para ambiente productivo o consola real debe ser false)

#backend
bucket         = "tfstate-bucket" #nombre del bucket que creaste al inicio
key            = "dev/terraform.tfstate"
region         = "us-east-1"
#dynamodb_table = "tu tabla de dynamo"
encrypt        = false
```

-- contenido terraform.tfvars--

```bash
#autenticación
profile = "tu perfil"

project = "tu proyecto"
environment = "tu entorno"
aws_region = "tu region"

# S3
bucket_Name = "Nombre-bucket-S3"

```
---

# Ir a la ruta de terraform para inciar desde alli

cd IAC/Terraform/

# reconfigurar el backend en tu terraform (opcional)

terraform init -reconfigure -backend-config=../../ENVIRONMENTS/dev/backend.tfvars

## Comandos de despliegue


# DEV
```bash
cd IAC/terraform/live/dev
#(si ya estas en Terraform ve directo a live <env>)
cd live/dev
terraform init -backend-config=../../ENVIRONMENTS/dev/backend.tfvars
terraform plan -var-file=../../ENVIRONMENTS/dev/terraform.tfvars -out tfplan
terraform apply tfplan
```

# PROD
```bash
cd IAC/terraform/live/prod
terraform init -backend-config=../../ENVIRONMENTS/prod/backend.tfvars
terraform plan -var-file=../../ENVIRONMENTS/prod/terraform.tfvars -out tfplan
terraform apply tfplan
```

# DESTRUYE

```bash

terraform destroy -var-file=../../ENVIRONMENTS/dev/terraform.tfvars

```