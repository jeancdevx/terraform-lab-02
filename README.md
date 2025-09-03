# Ambiente DEV con Terraform + Docker

Infraestructura local con Docker gestionada por Terraform:

- Redes: `app_net`, `persistence_net`, `monitor_net`
- Contenedores: `nginx`, `redis`, `postgres`, `grafana`

El proyecto usa Terraform Workspaces para levantar distintas instancias (app1, app2, app3) con puertos externos distintos.

## Requisitos

- Linux con Docker en ejecución (`docker --version`)
- Terraform ≥ 1.5 (`terraform version`)
- Usuario en el grupo docker (`sudo usermod -aG docker $USER` y re-login si aplica)
- Acceso a Internet para descargar imágenes

## Clonar y preparar

```bash
git clone <URL-del-repo>
cd terraform-lab-02

# Inicializar Terraform
terraform init
```

## Elegir workspace (instancia)

Usa uno de: `app1`, `app2`, `app3` (definidos en terraform.tfvars).

```bash
# Crear o seleccionar workspace
terraform workspace new app1 || terraform workspace select app1
```

## Plan y despliegue

```bash
terraform plan
terraform apply -auto-approve
```

## Acceso a servicios (según workspace)

Puertos por workspace (definidos en `terraform.tfvars`):

- app1: nginx 3000, redis 6379, postgres 5432, grafana 3005
- app2: nginx 3001, redis 6380, postgres 5433, grafana 3006
- app3: nginx 3002, redis 6381, postgres 5434, grafana 3007

Ejemplos (app1):

- Nginx: http://localhost:3000
- Grafana: http://localhost:3005

Ver contenedores y redes:

```bash
docker ps
docker network ls
```

## Cambiar de instancia

```bash
terraform workspace select app2
terraform apply -auto-approve
```

## Destruir

```bash
terraform destroy -auto-approve
```

## Notas

- Despliega una instancia por vez: `redis`, `postgres` y `grafana` no incluyen el workspace en el nombre del contenedor, por lo que no deben coexistir múltiples workspaces a la vez.
- Si un contenedor de `postgres` queda en estado Exited por configuración por defecto de la imagen, revisa logs:
  ```bash
  docker logs postgres
  ```
  y ajusta variables/entorno en `docker-containers.tf` si deseas contraseña/persistencia.
- Las redes se crean con Terraform. Si en el primer `apply` ves error de red inexistente,
