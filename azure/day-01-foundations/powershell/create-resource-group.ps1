# Creates an Azure Resource Group.
# Note: The Pluralsight sandbox used during testing restricts
# Resource Group creation through RBAC, resulting in HTTP 403.
# The sandbox-provided Resource Group was used for subsequent resources.

$resourceGroupName = "rg-cloud-dev-day01"
$location = "westus"

New-AzResourceGroup `
    -Name $resourceGroupName `
    -Location $location