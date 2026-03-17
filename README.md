<h1>Local stack y terraform con S3 reutilizable<h1/>

# Antes de inciar

** Instala AWS CLIv2

https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

** WSL2 (si estas en windows)

```bash
WSL --install
```

** Instala terraform

https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli


## clonar el repositorio

```bash
git clone https://github.com/SantiagoNieto887883/Terraform-localstack-aws-s3.git
```

## 1) levanta ambiente localstack en docker

Ejecuta el siguiente comando, esto levanta el ambiente con el documento compose

```bash
docker compose up -d --build
```
Verifica la salud del contenedor

```bash
curl http://localhost:4566/_localstack/health

```

Entra a la instancia para probrar comandos de localstack

```bash
docker exec terraform-localstack-aws-s3-localstack-1 sh -lc "awslocal ec2 describe-security-groups"
```
O

```bash
docker exec -it terraform-localstack-aws-s3-localstack-1 sh

#y

awslocal ec2 describe-security-groups
```

luego sales del contenedor 

```bash
exit
```

---

## (configurar credenciales SOLO PARA AMBIENTE LOCALSTACK)

Antes de correr terraform init

En Git Bash, deja limpias las credenciales así:

```bash
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
export AWS_DEFAULT_REGION=us-east-1
unset AWS_SESSION_TOKEN
unset AWS_PROFILE
```
Ese AWS_SESSION_TOKEN a veces rompe todo aunque access_key y secret estén bien.

Puedes validarlo con:

Ese AWS_SESSION_TOKEN a veces rompe todo aunque access_key y secret estén bien.

```bash
env | grep AWS
```

Deberías ver algo simple, idealmente solo:

```bash
AWS_ACCESS_KEY_ID=test
AWS_SECRET_ACCESS_KEY=test
AWS_DEFAULT_REGION=us-east-1
```
---

# Authentication

Debes autenticarte con tus credenciales de AWS (SSO o Secret key, access key) (usa las de localstack)

```bash
aws configure --profile <tu perfil>

o

aws configure sso --profile <tu perfil>

```

# verifica que estes en la cuenta:

```bash
aws sts get-caller-identity --profile <tu perfil>
```

El comando anterior te debe solicitar los valores de Secret key, access key.

Si utilizas SSO consulta en llaves de inicio de sesion los valores: (URL SSO, REGION)

---

## Comandos de despliegue

Verifica los prerrequisitos en:

https://github.com/SantiagoNieto887883/Terraform-localstack-aws/tree/main/IAC/Terraform

# DEV
```bash
cd IAC/terraform/live/dev
terraform init -backend-config=../../ENVIRONMETS/dev/backend.tfvars
terraform plan -var-file=../../ENVIRONMETS/dev/terraform.tfvars -out tfplan

## ver plan
terraform show tfplan > plan.txt


terraform apply tfplan
```

# PROD
```bash
cd IAC/terraform/live/prod
terraform init -backend-config=../../ENVIRONMETS/prod/backend.tfvars
terraform plan -var-file=../../ENVIRONMETS/prod/terraform.tfvars -out tfplan

## ver plan
terraform show tfplan > plan.txt

terraform apply tfplan
```.
```

## Subir imágenes al S3 local

En tu máquina (necesitas AWS CLI instalado):

```bash
cd ../../../../../Terraform-localstack-aws
aws --endpoint-url=http://localhost:4566 s3 cp ./imagenes/ s3://test-bucket-local/images/ --recursive
```
## confirma que las imagenes subieron

```bash
aws --endpoint-url=http://localhost:4566 s3 ls s3://test-bucket-local/images/
```

## Ver la app y confirma el contenido con las imagenes

Abre:

http://localhost:8080
