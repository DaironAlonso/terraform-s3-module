# terraform-s3-module

Solución para el cargo Profesional III DevOps - Banco Davivienda, es un módulo reutilizable de Terraform para provisionar buckets S3 en AWS con controles de seguridad habilitados por defecto.
***

## Controles de seguridad incluidos por defecto

| Control | Configuración |
|---------|--------------|
| **Block Public Access** | Todos los flags habilitados (`block_public_acls`, `block_public_policy`, `ignore_public_acls`, `restrict_public_buckets`) |
| **Versioning** | `Enabled` |
| **Cifrado en reposo** | AES-256 (SSE-S3) por defecto; soporte para KMS (SSE-KMS) opcional |
| **Política TLS-only** | Deniega toda petición que no use HTTPS (`aws:SecureTransport = false`) |

***

## Estructura del repositorio

```
terraform-s3-module/
├── .github/
│   └── workflows/
│       └── ci.yml          # Pipeline de CI (GitHub Actions)
├── modules/
│   └── s3/
│       ├── main.tf         # Recursos principales del módulo
│       ├── variables.tf    # Variables de entrada
│       ├── outputs.tf      # Valores de salida
│       └── versions.tf     # Restricciones de versión
├── main.tf                 # Ejemplo de consumo del módulo
├── variables.tf            # Variables del ejemplo raíz
├── outputs.tf              # Outputs del ejemplo raíz
├── providers.tf            # Configuración del proveedor AWS
├── terraform.tfvars.example
└── README.md
```

***

## Uso rápido

### 1. Consumir el módulo desde otro proyecto

```hcl
module "mi_bucket" {
  source = "github.com/DaironAlonso/terraform-s3-module//modules/s3"

  bucket_name = "mi-proyecto-assets-prod"
  environment = "prod"

  # Opcional: clave KMS propia
  # kms_key_arn = "arn:aws:kms:us-east-1:123456789012:key/mrk-xxx"

  tags = {
    Project = "mi-proyecto"
    Owner   = "platform-team"
  }
}
```

### 2. Ejecutar el ejemplo incluido en este repositorio

```bash
# Copiar y ajustar las variables
cp terraform.tfvars.example terraform.tfvars
# Editar terraform.tfvars con el nombre de bucket y región deseados

terraform init
terraform plan
terraform apply
```

***

## Variables

### Módulo `modules/s3`

| Variable | Tipo | Por defecto | Descripción |
|----------|------|-----------|-------------|-------------|
| `bucket_name` | `string` | — | Nombre único global del bucket |
| `environment` | `string` | `"dev"` | Entorno (`dev`, `staging`, `prod`) |
| `kms_key_arn` | `string`  | `null` | ARN de clave KMS (si `null` usa AES-256) |
| `tags` | `map(string)`  | `{}` | Tags adicionales |

***

## Outputs

| Output | Descripción |
|--------|-------------|
| `bucket_id` | Nombre del bucket creado |
| `bucket_arn` | ARN del bucket |
| `bucket_regional_domain_name` | Dominio regional del bucket |

***

## Pipeline de CI (GitHub Actions)

El workflow `.github/workflows/ci.yml` se dispara automáticamente en cada **Pull Request hacia `main`** que modifique archivos `.tf`.

### Pasos ejecutados

| Paso | Herramienta | Descripción |
|------|-------------|-------------|
| Checkout | `actions/checkout@v4` | Clona el repositorio |
| Setup Terraform | `hashicorp/setup-terraform@v3` | Instala Terraform 1.8.x |
| Format check | `terraform fmt -check -recursive` | Valida formato canónico |
| Init | `terraform init -backend=false` | Inicializa sin backend real |
| Validate | `terraform validate` | Valida sintaxis y semántica |
| Security scan | `checkov-action@v12` | Detecta vulnerabilidades IaC |
| PR Comment | `actions/github-script@v7` | Publica resumen en el PR |

> **Nota:** No se ejecuta `terraform apply`. El objetivo es validar calidad del código.

***

## Requisitos

- Terraform >= 1.5.0
- AWS Provider >= 5.0.0
- Credenciales AWS con permisos sobre S3 y KMS (solo para `apply`)

***

## Consideraciones de seguridad adicionales

- El módulo **siempre** bloquea el acceso público; no existe variable para desactivarlo.
- La política de bucket **rechaza conexiones sin TLS**, cumpliendo con CIS AWS Foundations Benchmark.
- Para ambientes productivos se recomienda proporcionar una clave KMS de cliente (`kms_key_arn`) en lugar de la clave por defecto de AWS.

***