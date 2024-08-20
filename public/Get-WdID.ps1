<#
.SYNOPSIS
    Gets the current time and date from Workday.

.DESCRIPTION
    Gets the current time and date, as a DateTime object, from Workday.

.PARAMETER Employee
    Employee name to be matched

.EXAMPLE

Get-WdWorker -WorkerId 123 -IncludePersonal

#>
function Get-WdID {
    [CmdletBinding()]
    param (
        [string]$Worker
    )

    If($Worker) {
        $WorkdayData | Where-Object {$_.WorkerDescriptor -like "*$Worker*"} | Format-Table | Write-Output
    }
    else {
        Write-Host "No employee name provided"
    }
}



