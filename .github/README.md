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

## Local Validation

Before pushing the Terraform configuration to GitHub, I tested it locally using WSL Ubuntu.

The following commands were used:

```bash
terraform fmt -check
terraform init
terraform validate
```

These checks confirmed:

- `terraform fmt -check` checked Terraform formatting
- `terraform init` initialized the working directory and downloaded the AzureRM provider
- `terraform validate` checked the HCL configuration for syntax and structural errors

The validation completed successfully:

```text
Success! The configuration is valid.
```

## Terraform Plan

A live `terraform plan` was not completed because the configuration requires authentication to Microsoft Azure.

To avoid unintended cloud costs, Azure credentials were intentionally not configured in this lab.

The current lab therefore focuses on safe local validation without connecting Terraform to a live Azure subscription.

A future controlled environment could add:

```bash
terraform plan
terraform apply
```

once Azure authentication and cost controls are in place.

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
- Live Azure planning deliberately avoided to prevent unintended cost

### Next

- Commit the validated Terraform configuration
- Run validation through GitHub Actions
- Add `terraform plan` later in a controlled Azure environment
- Add deployment only after Azure authentication and cost controls are configured
