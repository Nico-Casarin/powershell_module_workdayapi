function Save-WdConfiguration {
<#
.SYNOPSIS
    Saves default Workday configuration to a file in the current users Profile.

.DESCRIPTION
    Saves default Workday configuration to a file within the current
    users Profile. If it exists, this file is then read, each time the
    Workday Module is imported. Allowing settings to persist between
    sessions.

.EXAMPLE
    Save-WdConfiguration

#>

    [CmdletBinding()]
    param ()

    Export-Clixml -Path $ConfigurationFile -InputObject $WorkdayConfiguration
}



