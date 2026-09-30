# Terraform - Azure Day 1 Foundations

This folder contains the Terraform configuration used to recreate the Azure Day 1 infrastructure using Infrastructure as Code.

## Purpose

The goal of this lab is to move from manually creating Azure resources with PowerShell to defining the same infrastructure using Terraform.

This allows the infrastructure to be version controlled, validated, reviewed, and later deployed through CI/CD.

## Files

```text
terraform/
├── README.md
├── main.tf
├── outputs.tf
├── providers.tf
└── variables.tf
```

### providers.tf

Defines the Terraform configuration and AzureRM provider used to communicate with Microsoft Azure.

### variables.tf

Defines reusable input variables used by the Terraform configuration.

These allow values such as resource names and locations to be changed without editing the main resource definitions.

### main.tf

Contains the Azure infrastructure definitions.

Current configuration includes:

- Existing Azure Resource Group data source
- App Service Plan
- Linux Web App
- Resource dependencies

### outputs.tf

Defines values Terraform should display after processing the configuration.

Outputs can be used to retrieve useful resource information such as:

- Resource names
- Resource IDs
- Web App hostname

## Local Validation

Before pushing the Terraform configuration to GitHub, I tested it locally using WSL Ubuntu.

The following commands were used:

```bash
terraform fmt -check
terraform init
terraform validate
```

### terraform fmt -check

Checks that the Terraform configuration follows the expected formatting standards.

### terraform init

Initializes the Terraform working directory and downloads the required provider dependencies.

During this step Terraform downloaded the AzureRM provider and created the `.terraform.lock.hcl` dependency lock file.

### terraform validate

Checks the Terraform configuration for syntax and structural configuration errors.

The validation completed successfully:

```text
Success! The configuration is valid.
```

This confirmed that the Terraform HCL configuration was structurally valid before being committed and pushed to GitHub.

## Evidence

Validation evidence is stored in:

```text
docs/evidence/terraform-validation.png
```

![Terraform validation](../../../docs/evidence/terraform-validation.png)

## Current Status

### Completed

- Terraform configuration created
- AzureRM provider defined
- Variables created
- Azure resources defined
- Outputs configured
- Local formatting check completed
- Terraform initialization completed
- Terraform validation completed successfully

### Next

- Run `terraform plan`
- Review the proposed infrastructure changes
- Add Terraform plan validation to GitHub Actions
- Configure Azure authentication later
- Add controlled Terraform deployment using `terraform apply`

## Intended Terraform Workflow

```text
Write HCL configuration
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
Azure
```

## Learning Outcome

This lab demonstrates the process of defining Azure infrastructure using Terraform and validating Infrastructure as Code before deployment.

The next stage is to use `terraform plan` to compare the desired Terraform configuration against the target Azure environment before any changes are applied.
