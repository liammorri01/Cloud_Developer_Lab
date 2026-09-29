# Day 1 - Azure Foundations

## Goal

Understand the basic Azure landscape and deploy a simple cloud resource.

## Learning

- Azure navigation and deployment patterns
- Azure Identity and Access Management
- Azure compute fundamentals

## Practical Tasks

- [x] Log into Azure
- [x] Attempt to create a Resource Group with PowerShell
- [x] Deploy an App Service Plan
- [x] Deploy a Web App
- [x] Verify the Web App state
- [x] Retrieve the Web App hostname
- [ ] Find Activity Log
- [ ] Find IAM
- [ ] Find Metrics
- [ ] Find Deployment Center
- [ ] Find Resource Health

## Concepts to Explain

- What is a Resource Group?
- What is the difference between IaaS, PaaS and SaaS?
- Why use managed services instead of virtual machines?
- What does IAM do?

## Practical Notes

### Resource Group Creation

I attempted to create a Resource Group using Azure PowerShell:

```powershell
New-AzResourceGroup `
    -Name $resourceGroupName `
    -Location $location
```

The Pluralsight sandbox returned:

`403 Forbidden`

This occurred because the sandbox account did not have permission to create new Resource Groups at subscription scope.

This demonstrated how Azure RBAC controls which actions an authenticated identity can perform.

The sandbox-provided Resource Group was used for the rest of the lab.

### App Service Plan

I created an Azure App Service Plan using PowerShell.

```powershell
New-AzAppServicePlan `
    -Name $appServicePlanName `
    -ResourceGroupName $resourceGroupName `
    -Location $location `
    -Tier Free `
    -WorkerSize Small
```

The App Service Plan was created successfully.

### Web App

I then created a Web App using the App Service Plan.

```powershell
New-AzWebApp `
    -Name $webAppName `
    -ResourceGroupName $resourceGroupName `
    -Location $location `
    -AppServicePlan $appServicePlanName
```

The Web App entered the `Running` state.

### Verification

I verified the Web App using:

```powershell
Get-AzWebApp `
    -Name $webAppName `
    -ResourceGroupName $resourceGroupName
```

I also checked the application state and hostname.

Result:

- State: `Running`
- Hostname: `liam-cloud-dev-day01-webapp.azurewebsites.net`

## Current Resource Structure

```text
Resource Group
└── App Service Plan
    └── Web App
```