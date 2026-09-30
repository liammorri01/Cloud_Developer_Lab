# Day 1 - Azure App Service deployment

$resourceGroupName = "1-5b95602c-playground-sandbox"
$location = "westus"

$appServicePlanName = "asp-cloud-dev-day01"
$webAppName = "liam-cloud-dev-day01-webapp"

# Create App Service Plan
New-AzAppServicePlan `
    -Name $appServicePlanName `
    -ResourceGroupName $resourceGroupName `
    -Location $location `
    -Tier Free `
    -WorkerSize Small

# Create Web App
New-AzWebApp `
    -Name $webAppName `
    -ResourceGroupName $resourceGroupName `
    -Location $location `
    -AppServicePlan $appServicePlanName

# Verify Web App
Get-AzWebApp `
    -Name $webAppName `
    -ResourceGroupName $resourceGroupName

# Check Web App state
(Get-AzWebApp `
    -Name $webAppName `
    -ResourceGroupName $resourceGroupName).State

# Get public hostname
(Get-AzWebApp `
    -Name $webAppName `
    -ResourceGroupName $resourceGroupName).DefaultHostName