# deploy.ps1
# PowerShell script to deploy infrastructure with Terraform and deploy Python app to Azure App Service
# Follows Azure and PowerShell best practices, with error handling and clear output

param(
    [string]$TerraformDir = "./infra",
    [string]$AppDir = "./python_app",
    [string]$ResourceGroup = $null,
    [string]$AppServiceName = $null,
    [string]$SubscriptionId = $null
)

function Write-Log {
    param([string]$Message)
    Write-Host "[+] $Message" -ForegroundColor Cyan
}

function Throw-IfError {
    param($Result, [string]$ErrorMessage)
    if ($LASTEXITCODE -ne 0) {
        Write-Error "$ErrorMessage"
        exit 1
    }
}

Write-Log "Logging in to Azure..."
az account show > $null 2>&1
if ($LASTEXITCODE -ne 0) {
    az login
    Throw-IfError $LASTEXITCODE "Azure login failed."
}

if ($SubscriptionId) {
    Write-Log "Setting Azure subscription to $SubscriptionId..."
    az account set --subscription $SubscriptionId
    Throw-IfError $LASTEXITCODE "Failed to set Azure subscription."
}

Write-Log "Initializing Terraform in $TerraformDir..."
cd $TerraformDir
terraform init
Throw-IfError $LASTEXITCODE "Terraform init failed."

Write-Log "Applying Terraform plan..."
terraform apply -auto-approve
Throw-IfError $LASTEXITCODE "Terraform apply failed."

Write-Log "Retrieving Terraform outputs..."
$tfOutputs = terraform output -json | ConvertFrom-Json

if (-not $ResourceGroup) {
    $ResourceGroup = $tfOutputs.resource_group_name.value
}
if (-not $AppServiceName) {
    $AppServiceName = $tfOutputs.app_service_name.value
}

if (-not $ResourceGroup -or -not $AppServiceName) {
    Write-Error "Could not determine Resource Group or App Service Name from Terraform outputs."
    exit 1
}

cd ..

Write-Log "Deploying Python app from $AppDir to Azure App Service $AppServiceName in $ResourceGroup..."
az webapp deploy --resource-group $ResourceGroup --name $AppServiceName --src-path $AppDir
Throw-IfError $LASTEXITCODE "App deployment failed."

Write-Log "Deployment complete!"
