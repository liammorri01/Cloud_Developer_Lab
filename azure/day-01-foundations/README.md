## Goal
Understand the basic Azure landscape and deploy a simple cloud resource.

## Learning
- Azure navigation and deployment patterns
- Azure Identity and Access Management
- Azure compute fundamentals

## Practical Tasks
- [ ] Log into Azure
- [ ] Create a Resource Group
- [ ] Deploy a simple Azure service
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

## Notes
Add notes here as I work through the lab.
## Practical Notes

### Resource Group Creation

I attempted to create a Resource Group using Azure PowerShell:

```powershell
New-AzResourceGroup `
    -Name $resourceGroupName `
    -Location $location

Pluralsight sandbox returned : 403 forbidden 
 This occurred because the sandbox account does not have permission to create new Resource Groups at subscription scope.

This demonstrated how Azure RBAC controls which actions an authenticated identity can perform.   