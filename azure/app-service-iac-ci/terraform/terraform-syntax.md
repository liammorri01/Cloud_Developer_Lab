# Terraform Syntax Reference

## Basic Structure

Terraform files use HashiCorp Configuration Language (HCL).

Common file types include:

```text
main.tf
variables.tf
outputs.tf
providers.tf
terraform.tfvars
```

## Terraform Block

The `terraform` block defines Terraform requirements such as the minimum Terraform version and required providers.

```hcl
terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
```

## Providers

A provider allows Terraform to interact with an external platform.

Example:

```hcl
provider "azurerm" {
  features {}
}
```

`azurerm` is the Azure Resource Manager provider.

## Comments

Single-line comments can use:

```hcl
# This is a comment
```

or:

```hcl
// This is also a comment
```

Multi-line comments use:

```hcl
/*
This is a
multi-line comment
*/
```

## Variables

Variables allow values to be reused and changed without editing the infrastructure logic.

```hcl
variable "location" {
  description = "Azure region for resources."
  type        = string
  default     = "westus"
}
```

Reference the variable using:

```hcl
var.location
```

## Variable Types

Common Terraform types include:

```text
string
number
bool
list
set
map
object
```

Example:

```hcl
variable "environment" {
  type    = string
  default = "dev"
}
```

## tfvars Files

A `.tfvars` file can supply values separately from the Terraform configuration.

Example:

```hcl
resource_group_name = "rg-cloud-dev"
location            = "uksouth"
```

Terraform can then use those values without changing `main.tf`.

## Resources

A `resource` block defines infrastructure Terraform should create or manage.

Example:

```hcl
resource "azurerm_service_plan" "app_plan" {
  name                = var.app_service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "F1"
}
```

The structure is:

```text
resource "<resource_type>" "<local_name>"
```

For example:

```hcl
resource "azurerm_service_plan" "app_plan"
```

`azurerm_service_plan` is the Azure resource type.

`app_plan` is the local Terraform name used to reference it elsewhere.

## Referencing Resources

Terraform resources can reference other resources.

Example:

```hcl
service_plan_id = azurerm_service_plan.app_plan.id
```

This means:

```text
Provider resource type
        ↓
azurerm_service_plan

Local Terraform name
        ↓
app_plan

Property
        ↓
id
```

Full reference:

```hcl
azurerm_service_plan.app_plan.id
```

## Data Sources

A `data` block reads existing infrastructure instead of creating it.

Example:

```hcl
data "azurerm_resource_group" "sandbox" {
  name = var.resource_group_name
}
```

Reference it using:

```hcl
data.azurerm_resource_group.sandbox.name
```

This is useful when a resource already exists and should not be created by Terraform.

## Resource vs Data

```text
resource
→ Terraform creates or manages it

data
→ Terraform reads an existing resource
```

Example:

```hcl
data "azurerm_resource_group" "sandbox" {
  name = var.resource_group_name
}
```

Terraform looks up the Resource Group.

```hcl
resource "azurerm_service_plan" "app_plan" {
}
```

Terraform creates and manages the App Service Plan.

## Attributes

Resources expose attributes that can be referenced elsewhere.

Example:

```hcl
azurerm_service_plan.app_plan.id
```

Common attributes include:

```text
.id
.name
.location
.default_hostname
```

The available attributes depend on the resource type.

## Outputs

Outputs return useful values after Terraform runs.

Example:

```hcl
output "web_app_hostname" {
  description = "Public hostname of the Azure Web App."
  value       = azurerm_linux_web_app.web_app.default_hostname
}
```

After deployment, Terraform can display:

```text
web_app_hostname = "example.azurewebsites.net"
```

## Locals

`locals` can define reusable values inside the Terraform configuration.

```hcl
locals {
  environment = "dev"
  prefix      = "cloud-lab"
}
```

Reference them using:

```hcl
local.environment
local.prefix
```

## Expressions

Terraform values can be combined.

Example:

```hcl
name = "${var.environment}-webapp"
```

Modern Terraform can also often use direct expressions without interpolation.

Example:

```hcl
resource_group_name = var.resource_group_name
```

## Lists

A list stores multiple ordered values.

```hcl
variable "regions" {
  type = list(string)

  default = [
    "westus",
    "uksouth",
    "eastus"
  ]
}
```

Access a value using:

```hcl
var.regions[0]
```

## Maps

Maps store key-value pairs.

```hcl
variable "tags" {
  type = map(string)

  default = {
    environment = "dev"
    project     = "cloud-lab"
  }
}
```

Access a value using:

```hcl
var.tags["environment"]
```

## Tags

Azure resources can use tags for organisation.

Example:

```hcl
tags = {
  environment = "dev"
  project     = "cloud-developer-lab"
}
```

## Dependency Relationships

Terraform automatically builds dependencies when one resource references another.

Example:

```hcl
resource "azurerm_linux_web_app" "web_app" {
  service_plan_id = azurerm_service_plan.app_plan.id
}
```

Terraform understands that the App Service Plan must exist before the Web App can be created.

The dependency becomes:

```text
App Service Plan
        ↓
Web App
```

## depends_on

Terraform normally detects dependencies automatically.

For unusual cases, an explicit dependency can be added:

```hcl
depends_on = [
  azurerm_service_plan.app_plan
]
```

Use this only when Terraform cannot infer the dependency itself.

## Lifecycle

Terraform can control how resources are replaced or deleted.

Example:

```hcl
lifecycle {
  prevent_destroy = true
}
```

Another example:

```hcl
lifecycle {
  create_before_destroy = true
}
```

## Terraform Commands

### Initialise

```bash
terraform init
```

Downloads required providers and prepares the working directory.

### Format

```bash
terraform fmt
```

Automatically formats Terraform files.

Check formatting without changing files:

```bash
terraform fmt -check
```

### Validate

```bash
terraform validate
```

Checks whether the Terraform configuration is syntactically valid.

### Plan

```bash
terraform plan
```

Shows what Terraform intends to create, change, or destroy.

### Apply

```bash
terraform apply
```

Applies the planned infrastructure changes.

### Destroy

```bash
terraform destroy
```

Destroys infrastructure managed by the Terraform configuration.

Use carefully.

## Terraform Workflow

A common Terraform workflow is:

```text
Write configuration
        ↓
terraform fmt
        ↓
terraform init
        ↓
terraform validate
        ↓
terraform plan
        ↓
Review changes
        ↓
terraform apply
        ↓
Verify infrastructure
```

## Terraform State

Terraform keeps track of managed infrastructure using state.

The default local state file is:

```text
terraform.tfstate
```

State records the relationship between Terraform configuration and real infrastructure.

State files can contain sensitive information and should not normally be committed to Git.

## .gitignore

Terraform-generated files should usually be excluded from Git.

Common entries:

```gitignore
.terraform/
*.tfstate
*.tfstate.*
.terraform.lock.hcl
crash.log
```

Note: many teams do commit `.terraform.lock.hcl` to keep provider versions consistent. Whether you exclude it depends on the project workflow.

## Sensitive Variables

Variables can be marked sensitive:

```hcl
variable "client_secret" {
  type      = string
  sensitive = true
}
```

This reduces accidental display in Terraform output.

Sensitive credentials should still not be committed directly into `.tf` or `.tfvars` files.

## Environment Variables

Terraform variables can also be supplied through environment variables.

Example:

```bash
export TF_VAR_location="uksouth"
```

Terraform then maps this to:

```hcl
variable "location" {
  type = string
}
```

## Useful Azure Terraform Pattern

A common Azure Terraform flow is:

```text
Provider
↓
Existing Resource Group
↓
App Service Plan
↓
Web App
↓
Outputs
```

Example:

```hcl
data "azurerm_resource_group" "sandbox" {
  name = var.resource_group_name
}

resource "azurerm_service_plan" "app_plan" {
  name                = var.app_service_plan_name
  resource_group_name = data.azurerm_resource_group.sandbox.name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "F1"
}

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

## Key Concepts

```text
provider
→ tells Terraform which platform to interact with

variable
→ configurable input value

resource
→ infrastructure Terraform creates or manages

data
→ infrastructure Terraform reads but does not create

output
→ value returned after Terraform runs

state
→ Terraform's record of managed infrastructure

plan
→ preview of proposed changes

apply
→ make the proposed changes
```