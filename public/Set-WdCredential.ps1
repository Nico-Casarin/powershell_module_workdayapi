function Set-WdCredential {
<#
.SYNOPSIS
    Sets the default Workday API credentials.

.DESCRIPTION
    Sets the default Workday API credentials. Configuration values can
    be securely saved to a user's profile using Save-WdConfiguration.

.PARAMETER Credential
    A standard Powershell Credential object. Optional.

.EXAMPLE
    Set-WdCredential

    This will prompt the user for credentials and save them in memory.

.EXAMPLE
    $cred = Get-Credential -Message 'Custom message...' -UserName 'Custom Username'
    Set-WdCredential -Credential $cred

    This demonstrates prompting the user with a custom message and default username.

#>

    [CmdletBinding()]
    param (
        [PSCredential]$Credential = $(Get-Credential -Message 'Enter Workday API credentials.')
    )

    $WorkdayConfiguration.Credential = $Credential
}




