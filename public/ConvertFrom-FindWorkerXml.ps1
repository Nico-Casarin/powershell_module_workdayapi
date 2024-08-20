function ConvertFrom-FindWorkerXml {
    <#
    .Synopsis
       Converts Workday Worker XML into a custom object.
    #>
        [CmdletBinding()]
        [OutputType([pscustomobject])]
        Param (
            [Parameter(Mandatory=$true,
                ValueFromPipeline=$true,
                ValueFromPipelineByPropertyName=$true,
                Position=0)]
            [xml[]]$Xml
        )
    
        Begin {
            $WorkerObjectTemplate = [pscustomobject][ordered]@{
                WorkerWid             = $null
                WorkerDescriptor      = $null
                WorkerType            = $null
                WorkerId              = $null
            }
            $WorkerObjectTemplate.PsObject.TypeNames.Insert(0, "Workday.Worker")
            $workerObjects = @()
        }
    
        Process {

            foreach ($elements in $Xml) {
                foreach ($x in $elements.SelectNodes('//wd:Worker', $NM)) {
                    $o = $WorkerObjectTemplate.PsObject.Copy()
    
                    $referenceId = $x.Worker_Reference.ID | Where-Object {$_.type -ne 'WID'}
    
                    $o.WorkerWid        = $x.Worker_Reference.ID | Where-Object {$_.type -eq 'WID'} | Select-Object -ExpandProperty '#text'
                    $o.WorkerDescriptor = $x.Worker_Descriptor
                    $o.WorkerType       = $referenceId.type
                    $o.WorkerId         = $referenceId.'#text'

                    $workerObjects += $o}
            
                    # Convert the array to CSV-formatted string (excluding type information)
                    $csvOutput = $workerObjects | ConvertTo-Csv -NoTypeInformation
                    # Get the user's home directory
  
                    # Append the CSV data to the existing file
                    $csvOutput | Select-Object -Skip 1 | Add-Content -Path $csvFilePath -Encoding UTF8
                    # Print a success message
                    Write-Output "Data appended to $csvFilePath"

            }
        }
    }
    


