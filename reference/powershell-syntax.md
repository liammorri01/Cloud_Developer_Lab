# PowerShell Syntax Reference

## Variables

PowerShell variables begin with `$`.

```powershell
$resourceGroupName = "rg-cloud-dev-day01"
$location = "westus"
```

Reference them later using the variable name:

```powershell
$resourceGroupName
$location
```

## Cmdlets

PowerShell commands commonly follow the format:

```text
Verb-Noun
```

Examples:

```powershell
Get-AzResourceGroup
New-AzWebApp
New-AzAppServicePlan
```

Common verbs include:

- `Get` - retrieve information
- `New` - create something
- `Set` - modify something
- `Remove` - delete something
- `Start` - start something
- `Stop` - stop something

## Parameters

Parameters are passed to cmdlets using a hyphen:

```powershell
Get-AzResourceGroup -Name $resourceGroupName
```

Multiple parameters can be used:

```powershell
New-AzWebApp `
    -Name $webAppName `
    -ResourceGroupName $resourceGroupName `
    -Location $location
```

## Line Continuation

A backtick allows a PowerShell command to continue onto the next line:

```powershell
New-AzResourceGroup `
    -Name $resourceGroupName `
    -Location $location
```

This is mainly used to improve readability.

## Comments

Single-line comments use `#`.

```powershell
# Create an Azure Resource Group
New-AzResourceGroup
```

Multi-line comments use:

```powershell
<#
This is a
multi-line comment.
#>
```

## Accessing Object Properties

PowerShell commands often return objects.

You can access an object's property using:

```powershell
.ObjectProperty
```

Example:

```powershell
(Get-AzWebApp `
    -Name $webAppName `
    -ResourceGroupName $resourceGroupName).State
```

This returns the `State` property of the Web App.

Another example:

```powershell
(Get-AzWebApp `
    -Name $webAppName `
    -ResourceGroupName $resourceGroupName).DefaultHostName
```

## Storing Command Output

The result of a command can be stored in a variable:

```powershell
$webApp = Get-AzWebApp `
    -Name $webAppName `
    -ResourceGroupName $resourceGroupName
```

Then properties can be accessed later:

```powershell
$webApp.State
$webApp.DefaultHostName
```

## Arrays

Arrays store multiple values:

```powershell
$regions = @(
    "westus",
    "uksouth",
    "eastus"
)
```

Access an item by position:

```powershell
$regions[0]
```

## Hashtables

Hashtables store key-value pairs:

```powershell
$config = @{
    ResourceGroup = "rg-cloud-dev"
    Location      = "westus"
}
```

Access a value using:

```powershell
$config.ResourceGroup
```

## If Statements

Conditional logic uses `if`.

```powershell
if ($webApp.State -eq "Running") {
    Write-Host "Web App is running"
}
```

With an alternative:

```powershell
if ($webApp.State -eq "Running") {
    Write-Host "Web App is running"
}
else {
    Write-Host "Web App is not running"
}
```

## Comparison Operators

Common PowerShell comparison operators:

```text
-eq   Equal
-ne   Not equal
-gt   Greater than
-lt   Less than
-ge   Greater than or equal
-le   Less than or equal
```

Example:

```powershell
if ($status -eq "Running") {
    Write-Host "Healthy"
}
```

## Loops

### foreach

```powershell
$resources = @(
    "DNS01",
    "MON01",
    "WEB01"
)

foreach ($resource in $resources) {
    Write-Host $resource
}
```

## Functions

Functions allow reusable blocks of code:

```powershell
function Get-WebAppStatus {
    param (
        $WebAppName,
        $ResourceGroupName
    )

    Get-AzWebApp `
        -Name $WebAppName `
        -ResourceGroupName $ResourceGroupName
}
```

Call the function with:

```powershell
Get-WebAppStatus `
    -WebAppName $webAppName `
    -ResourceGroupName $resourceGroupName
```

## Output

Display text:

```powershell
Write-Host "Deployment complete"
```

Display a variable:

```powershell
Write-Host $webAppName
```

Combine text and variables:

```powershell
Write-Host "Web App: $webAppName"
```

## Pipelines

The pipe `|` sends output from one command into another.

Example:

```powershell
Get-AzResourceGroup | Select-Object ResourceGroupName, Location
```

Another example:

```powershell
Get-AzWebApp | Where-Object State -eq "Running"
```

## Select-Object

Select specific properties:

```powershell
Get-AzWebApp |
    Select-Object Name, State, DefaultHostName
```

## Where-Object

Filter returned objects:

```powershell
Get-AzWebApp |
    Where-Object State -eq "Running"
```

## Error Handling

Basic error handling uses `try` and `catch`:

```powershell
try {
    Get-AzResourceGroup -Name $resourceGroupName -ErrorAction Stop
}
catch {
    Write-Host "Resource Group could not be found"
}
```

## Useful Azure PowerShell Pattern

A common Azure workflow is:

```text
Define variables
↓
Create resource
↓
Retrieve resource
↓
Check properties
↓
Handle errors
```

Example:

```powershell
$resourceGroupName = "rg-cloud-dev"

try {
    $resourceGroup = Get-AzResourceGroup `
        -Name $resourceGroupName `
        -ErrorAction Stop

    Write-Host "Resource Group found:"
    Write-Host $resourceGroup.ResourceGroupName
}
catch {
    Write-Host "Resource Group not found"
}
```

## Commands Used in This Lab

```powershell
New-AzResourceGroup
Get-AzResourceGroup
New-AzAppServicePlan
New-AzWebApp
Get-AzWebApp
```

These commands are provided by the Azure PowerShell `Az` modules.