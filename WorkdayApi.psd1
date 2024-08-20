@{
    Description = 'Provides a means to access the Workday SOAP API in a Powershell friendly manner.'
    ModuleVersion = '3.0.0'
    HelpInfoURI = 'https://github.com/Nico-Casarin/powershell_module_workdayapi'
    Author = 'Nathan Hartley'
    RootModule = 'WorkdayApi.psm1'
    PowerShellVersion = '5.1'
    CompatiblePSEditions = @('Desktop', 'Core')
    PrivateData = @{
        PSData = @{
            Tags = @('Workday')
            LicenseUri = 'https://github.com/Nico-Casarin/powershell_module_workdayapi/blob/main/License.txt'
            ProjectUri = 'https://github.com/Nico-Casarin/powershell_module_workdayapi/'
            ReleaseNotes = @'


Change log available at: https://github.com/Nico-Casarin/powershell_module_workdayapi/blob/master/CHANGELOG.md 
'@
        }
    }
    FunctionsToExport = @(
        'ConvertFrom-FindWorkerXml',
        'ConvertFrom-WdWorkerXml',
        'Get-WdReport',
        'Get-WdWorker',
        'Get-WdWorkerByIdLookupTable',
        'Invoke-WdRequest',
        'Remove-WdConfiguration',
        'Get-WdWorkerPhoto',
        'Update-WdWorker'
        'Get-WdID'
	    #'Set-WdWorkerPhoto',
        
        'Get-WdEndpoint',
        'Set-WdCredential',
        'Set-WdEndpoint',
        'Save-WdConfiguration',
        
        'Get-WdWorkerEmail',
	    'Set-WdWorkerEmail',
        'Update-WdWorkerEmail',
        
        'Get-WdWorkerDocument',
        'Set-WdWorkerDocument',
        
        #'Get-WdWorkerNationalId',
        
        'Get-WdWorkerOtherId',
        #'Remove-WdWorkerOtherId',
        'Set-WdWorkerOtherId',
        'Update-WdWorkerOtherId',
        
        'Get-WdWorkerPhone',
	    'Set-WdWorkerPhone',
        'Update-WdWorkerPhone',
        
        #'Start-WdIntegration',
        'Get-WdIntegrationEvent',
        
        'Get-WdDate'
	
	    #'Set-WdWorkerUserId'
    )
    GUID = 'bd4390dc-a8ad-4bce-8d69-f53ccf8e4163'
}
