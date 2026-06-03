#!/usr/bin/env bash
# deploy.sh
# Bash script to deploy infrastructure with Terraform and deploy Python app to Azure App Service
# Follows Azure and Bash best practices, with error handling and clear output

set -euo pipefail

TERRAFORM_DIR="${TERRAFORM_DIR:-./infra}"
APP_DIR="${APP_DIR:-./python_app}"
SUBSCRIPTION_ID="${SUBSCRIPTION_ID:-}"

log() {
  echo -e "\033[1;36m[+] $1\033[0m"
}

err() {
  echo -e "\033[1;31m[!] $1\033[0m" >&2
  exit 1
}

log "Checking Azure CLI login..."
az account show > /dev/null 2>&1 || az login || err "Azure login failed."

if [[ -n "$SUBSCRIPTION_ID" ]]; then
  log "Setting Azure subscription to $SUBSCRIPTION_ID..."
  az account set --subscription "$SUBSCRIPTION_ID" || err "Failed to set Azure subscription."
fi

log "Initializing Terraform in $TERRAFORM_DIR..."
cd "$TERRAFORM_DIR"
terraform init || err "Terraform init failed."

log "Applying Terraform plan..."
terraform apply -auto-approve || err "Terraform apply failed."

log "Retrieving Terraform outputs..."
TF_OUTPUT=$(terraform output -json)
RESOURCE_GROUP=$(echo "$TF_OUTPUT" | jq -r '.resource_group_name.value')
APP_SERVICE_NAME=$(echo "$TF_OUTPUT" | jq -r '.app_service_name.value')

if [[ -z "$RESOURCE_GROUP" || -z "$APP_SERVICE_NAME" ]]; then
  err "Could not determine Resource Group or App Service Name from Terraform outputs."
fi

cd - > /dev/null

log "Deploying Python app from $APP_DIR to Azure App Service $APP_SERVICE_NAME in $RESOURCE_GROUP..."
az webapp deploy --resource-group "$RESOURCE_GROUP" --name "$APP_SERVICE_NAME" --src-path "$APP_DIR" || err "App deployment failed."

log "Deployment complete!"
