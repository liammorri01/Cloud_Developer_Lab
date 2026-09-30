# GitHub Automation

This folder contains GitHub-specific configuration for the Cloud Developer Lab.

## Workflows

The `workflows/` directory contains GitHub Actions pipelines used to automate Terraform validation and, later, deployment.

### terraform.yml

The current Terraform workflow is designed to:

- Detect Terraform changes
- Check out the repository
- Install Terraform
- Run `terraform fmt`
- Run `terraform init`
- Run `terraform validate`

Planned additions include:

- Run `terraform plan` in a controlled Azure environment
- Later deploy infrastructure using `terraform apply`

## Workflow Location

```text
.github/
├── README.md
└── workflows/
    └── terraform.yml
```

## Goal

The purpose of the workflow is to move from manually running Terraform commands to a repeatable CI/CD process.

The intended flow is:

```text
Code change
    ↓
Git push / Pull Request
    ↓
GitHub Actions
    ↓
Terraform formatting check
    ↓
Terraform validation
    ↓
Terraform plan
    ↓
Review / approval
    ↓
Terraform deployment
    ↓
Azure
```

## Current Status

The Terraform pipeline is being built incrementally as part of the Azure Day 1 lab.

Current automated checks include:

- Terraform formatting
- Terraform initialization
- Terraform validation

`terraform plan` and Azure deployment authentication are intentionally not enabled yet to avoid connecting this lab to a billable Azure environment.
