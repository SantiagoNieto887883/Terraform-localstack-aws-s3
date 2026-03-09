<h1>Local stack y terraform<h1/>

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
docker exec terraform-localstack-aws-localstack-1 sh -lc "awslocal ec2 describe-security-groups"

#o

docker exec -it terraform-localstack-aws-localstack-1 sh

#y

awslocal ec2 describe-security-groups

#luego sales del contenedor 

exit

```

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

## Ver la app

Abre:

http://localhost:8080

```bash
```

```bash
```

```bash
```

```bash
```

```bash
```

```bash
```

```bash
```

```bash
```

```bash
```

```bash
```

```bash
```

```bash
```