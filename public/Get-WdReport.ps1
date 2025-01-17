function Get-WdReport {
<#
.SYNOPSIS
    Returns the XML result from any Workday report, based on its URI.

.DESCRIPTION
    Returns the XML result from any Workday report, based on its URI.

.PARAMETER Uri
    Uri for the report.

.PARAMETER Username
    Username used to authenticate with Workday. If empty, the value stored
    using Set-WdCredential will be used.

.PARAMETER Password
    Password used to authenticate with Workday. If empty, the value stored
	using Set-WdCredential will be used.

.NOTES
	TODO: Create a parameter that accepts a report name, rather than parsing a Uri.

#>

	[CmdletBinding()]
    [OutputType([XML])]
	param (
		[Parameter(Mandatory = $true)]
		[ValidateNotNullOrEmpty()]
		[string]$Uri,
		[string]$Username,
		[string]$Password
	)

	if ($Uri -match '\/([a-z0-9-_]+)(\?|$)') {
		$reportName = $Matches[1]
	} else {
		throw "A valid report name was not found in the Uri: $Uri"
	}

	$request = @'
         <role:Execute_Report xmlns:role="urn:com.workday.report/{0}"></role:Execute_Report>
'@ -f $reportName

Write-Progress -Activity 'WorkdayAPI Find Worker Request' -Status "Request in progress"
$response = Invoke-WdRequest -Request $request -Uri $Uri -Username:$Username -Password:$Password

#Write-Progress -Activity 'WorkdayAPI Find Worker Request' -Status "Request in progress"
#Write-Host $response
$response.Xml | ConvertFrom-FindWorkerXml
}


