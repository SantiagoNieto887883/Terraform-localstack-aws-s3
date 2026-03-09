# Infraestructura S3 PARA UNA APP EN PYTON

proyecto de s3 de manera modulada en AWS

---

# antes de iniciar

debes crear los archivos .tfvars en las rutas:

```bash
IAC/terraform/ENVIRONMETS/<env>/backend.tfvars

IAC/terraform/ENVIRONMETS/<env>/terraform.tfvars
```

-- contenido backend.tfvar--

```bash
#autenticación
profile = "tu perfil"

bucket         = "tu bucket"
key            = "tu ruta/terraform.tfstate"
region         = "tu region"
#dynamodb_table = "tu tabla de dynamo"
encrypt        = true
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

# reconfigurar el backend en tu terraform (opcional)

terraform init -reconfigure -backend-config=../../ENVIRONMETS/dev/backend.tfvars

## Comandos de despliegue


# DEV
```bash
cd IAC/terraform/live/dev
terraform init -backend-config=../../ENVIRONMETS/dev/backend.tfvars
terraform plan -var-file=../../ENVIRONMETS/dev/terraform.tfvars -out tfplan
terraform apply tfplan
```

# PROD
```bash
cd IAC/terraform/live/prod
terraform init -backend-config=../../ENVIRONMETS/prod/backend.tfvars
terraform plan -var-file=../../ENVIRONMETS/prod/terraform.tfvars -out tfplan
terraform apply tfplan
```

# DESTRUYE

```bash

terraform destroy -var-file=../../ENVIRONMETS/dev/terraform.tfvars

```