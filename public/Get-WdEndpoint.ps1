function Get-WdEndpoint {
<#
.SYNOPSIS
    Gets the default Uri value for all or a particular Endpoint.

.DESCRIPTION
    Gets the default Uri value for all or a particular Endpoint.

.PARAMETER Endpoint
    The curent Endpoints used by this module are:
    'Human_Resources', 'Staffing'

.EXAMPLE

Get-WdEndpoint -Endpoint Staffing

    Demonstrates how to get a single Endpoint value.

.EXAMPLE

Get-WdEndpoint

    Demonstrates how to get all of the Endpoint values.

#>

    [CmdletBinding()]
    param (
        [parameter(Mandatory=$false)]
        [ValidateSet('Human_Resources', 'Integrations', 'Staffing')]
        [string]$Endpoint
    )

    if ([string]::IsNullOrWhiteSpace($Endpoint)) {
        Write-Output $WorkdayConfiguration.Endpoints
    } else {
        Write-Output $WorkdayConfiguration.Endpoints[$Endpoint]
    }
}



