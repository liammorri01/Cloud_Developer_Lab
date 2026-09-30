# Terraform - Day 1

## Goal

Recreate the Azure App Service deployment using Terraform and Infrastructure as Code.

The Pluralsight sandbox already provides the Resource Group, so Terraform reads the existing Resource Group instead of attempting to create a new one.

## Files

### providers.tf

Defines the Terraform and AzureRM provider requirements.

This file tells Terraform:

- Which Terraform version is supported
- Which provider is required
- That Azure Resource Manager will be used

### variables.tf

Defines reusable input values for the deployment.

Current variables include:

- Resource Group name
- Azure region
- App Service Plan name
- Web App name

Using variables allows the Terraform configuration to be reused without changing the infrastructure logic in `main.tf`.

### main.tf

Defines the Azure infrastructure.

The configuration:

1. Reads the existing sandbox Resource Group
2. Creates an Azure App Service Plan
3. Creates a Linux Web App
4. Connects the Web App to the App Service Plan

### outputs.tf

Returns useful values after deployment.

Current outputs include:

- App Service Plan name
- Web App name
- Web App public hostname

## Infrastructure

The Terraform configuration represents the following structure:

```text
Existing Resource Group
└── App Service Plan
    └── Linux Web App
```

## Existing Resource Group

Because the Pluralsight sandbox restricts Resource Group creation, Terraform reads the existing Resource Group using a data source:

```hcl
data "azurerm_resource_group" "sandbox" {
  name = var.resource_group_name
}
```

A `data` block reads existing infrastructure instead of creating it.

## App Service Plan

Terraform creates the App Service Plan using:

```hcl
resource "azurerm_service_plan" "app_plan" {
  name                = var.app_service_plan_name
  resource_group_name = data.azurerm_resource_group.sandbox.name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "F1"
}
```

This defines the compute plan used by the Web App.

## Web App

The Linux Web App is created using:

```hcl
resource "azurerm_linux_web_app" "web_app" {
  name                = var.web_app_name
  resource_group_name = data.azurerm_resource_group.sandbox.name
  location            = var.location
  service_plan_id     = azurerm_service_plan.app_plan.id

  site_config {
    always_on = false
  }
}
```

The Web App references:

```hcl
azurerm_service_plan.app_plan.id
```

This creates an automatic dependency between the App Service Plan and Web App.

Terraform therefore understands that the App Service Plan must exist before the Web App can be created.

## Outputs

After deployment, Terraform can return important resource information:

```hcl
output "web_app_hostname" {
  description = "Default public hostname of the Azure Web App."
  value       = azurerm_linux_web_app.web_app.default_hostname
}
```

This provides the public Azure hostname without needing to manually locate it in the portal.

## Terraform Workflow

The deployment workflow will be:

```text
terraform fmt
    ↓
terraform init
    ↓
terraform validate
    ↓
terraform plan
    ↓
Review proposed changes
    ↓
terraform apply
    ↓
Verify deployed resources
```

## PowerShell vs Terraform

The PowerShell deployment used imperative commands:

```text
Create the App Service Plan
↓
Create the Web App
↓
Retrieve the Web App
↓
Check its properties
```

Terraform uses a declarative approach:

```text
Define the desired infrastructure
↓
Terraform calculates dependencies
↓
Terraform creates the required resources
↓
Terraform stores the resulting state
```

## What I Learned

- Terraform uses declarative Infrastructure as Code
- Providers allow Terraform to interact with platforms such as Azure
- Variables make infrastructure configurations reusable
- `resource` blocks create or manage infrastructure
- `data` blocks read existing infrastructure
- Resource references create automatic dependencies
- Outputs return useful information after deployment
- Terraform state tracks the relationship between configuration and real infrastructure

## Next Step

The next stage is to run this Terraform configuration through a GitHub Actions pipeline so that validation, planning, and deployment can be automated.