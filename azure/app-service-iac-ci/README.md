# Azure Day 1 Foundations

This lab focuses on building core Azure administration and Infrastructure as Code skills using PowerShell, Terraform, and GitHub Actions.

## Goal

The goal of Day 1 was to:

- Inspect and work with Azure resources
- Create and verify Azure resources using PowerShell
- Troubleshoot Azure RBAC and PowerShell errors
- Recreate the same infrastructure using Terraform
- Validate the Terraform configuration locally
- Begin building a CI pipeline with GitHub Actions
- Document the process and evidence

## Lab Components

### PowerShell

Azure PowerShell was used to:

- Inspect the sandbox Resource Group
- Create an App Service Plan
- Create an Azure Web App
- Verify the Web App state
- Retrieve the Web App hostname
- Troubleshoot a `403 Forbidden` RBAC error
- Troubleshoot a PowerShell parameter-set error

More detail:

```text
powershell/README.md
```

### Terraform

Terraform was used to define the Azure infrastructure using Infrastructure as Code.

The configuration includes:

- AzureRM provider
- Existing Resource Group data source
- App Service Plan
- Linux Web App
- Reusable variables
- Outputs
- Resource dependencies

Local validation was completed using:

```bash
terraform fmt -check
terraform init
terraform validate
```

The configuration validated successfully.

A live `terraform plan` was intentionally not completed because Azure authentication was not configured in order to avoid unintended cloud costs.

More detail:

```text
terraform/README.md
```

### GitHub Actions

A GitHub Actions workflow was created to begin automating Terraform validation.

The current CI workflow includes:

```text
Git push / Pull Request
        ↓
GitHub Actions
        ↓
Checkout repository
        ↓
Setup Terraform
        ↓
terraform fmt -check
        ↓
terraform init
        ↓
terraform validate
```

Future stages will include `terraform plan` and controlled deployment once Azure authentication and cost controls are available.

## Troubleshooting

### Azure RBAC

Attempting to create a new Resource Group in the Pluralsight Azure Sandbox returned:

```text
403 Forbidden
```

This demonstrated that successful authentication does not automatically grant permission to perform every action.

The sandbox-provided Resource Group was used instead.

### PowerShell Parameter Error

The first App Service Plan deployment attempt produced a parameter-set error.

The PowerShell command was reviewed and corrected before the resource was successfully created.

### Terraform Plan Authentication

`terraform plan` could not run because Azure CLI authentication was not configured.

This was intentionally left unresolved to avoid connecting the lab to a billable Azure subscription.

## Evidence

Evidence captured during the lab includes:

- Existing Azure Resource Group
- App Service Plan error
- Successful App Service Plan deployment
- App Service Plan visible in Azure Portal
- Web App creation
- Web App verification
- Terraform validation

Evidence is stored under:

```text
images/
../../../docs/evidence/
```

## Learning Outcomes

Day 1 demonstrated several important cloud and DevOps concepts:

- Azure authentication and RBAC are separate concerns
- PowerShell can be used to automate Azure administration
- Infrastructure should be verified after deployment
- Terraform allows infrastructure to be defined declaratively
- `terraform validate` checks configuration without requiring deployment
- `terraform plan` may require live provider authentication
- GitHub Actions can automate repeatable validation
- CI and deployment should be separated until safe authentication and cost controls are in place

## Current Status

### Completed

- Azure resource inspection
- PowerShell resource deployment
- Resource verification
- RBAC troubleshooting
- PowerShell troubleshooting
- Terraform configuration
- Terraform initialization
- Terraform validation
- GitHub Actions CI workflow setup
- Evidence documentation

### Next

- Run Terraform validation in GitHub Actions
- Capture CI evidence
- Add `terraform plan` later in a controlled Azure environment
- Add deployment only after authentication and cost controls are configured
