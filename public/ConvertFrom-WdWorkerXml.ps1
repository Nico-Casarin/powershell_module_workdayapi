function ConvertFrom-WdWorkerXml {
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
            Active                = $null
            WorkerDescriptor      = $null
            PreferredName         = $null
            FirstName             = $null
            LastName              = $null
            WorkerType            = $null
            WorkerId              = $null
            UserId                = $null
            # NationalId            = $null
            # OtherId               = $null
            # Phone                 = $null
            # Email                 = $null
            BusinessTitle         = $null
            #JobProfileName        = $null
            Location              = $null
            #WorkSpace             = $null
            WorkerTypeReference   = $null
            Manager               = $null
            #Company               = $null
            #BusinessUnit          = $null
            #Supervisory           = $null
            #XML                   = $null
        }
        $WorkerObjectTemplate.PsObject.TypeNames.Insert(0, "Workday.Worker")
    }

    Process {
        foreach ($elements in $Xml) {
            foreach ($x in $elements.SelectNodes('//wd:Worker', $NM)) {
                $o = $WorkerObjectTemplate.PsObject.Copy()

                $referenceId = $x.Worker_Reference.ID | Where-Object {$_.type -ne 'WID'}

                $o.WorkerWid        = $x.Worker_Reference.ID | Where-Object {$_.type -eq 'WID'} | Select-Object -ExpandProperty '#text'
                $o.WorkerDescriptor = $x.Worker_Descriptor
                $o.PreferredName    = $x.Worker_Data.Personal_Data.Name_Data.Preferred_Name_Data.Name_Detail_Data.Formatted_Name
                $o.FirstName        = $x.Worker_Data.Personal_Data.Name_Data.Preferred_Name_Data.Name_Detail_Data.First_Name
                $o.LastName         = $x.Worker_Data.Personal_Data.Name_Data.Preferred_Name_Data.Name_Detail_Data.Last_Name
                $o.UserId           = $x.Worker_Data.User_ID
                $o.WorkerType       = $referenceId.type
                $o.WorkerId         = $referenceId.'#text'
                #$o.XML              = [XML]$x.OuterXml

                # $o.Phone      = @(Get-WdWorkerPhone -WorkerXml $x.OuterXml)
                # $o.Email      = @(Get-WdWorkerEmail -WorkerXml $x.OuterXml)
                # $o.NationalId = @(Get-WdWorkerNationalId -WorkerXml $x.OuterXml)
                # $o.OtherId    = @(Get-WdWorkerOtherId -WorkerXml $x.OuterXml)
                

                # The methods SelectNodes and SelectSingleNode have access to the entire XML document and require anchoring with "./" to work as expected.
                $workerEmploymentData = $x.SelectSingleNode('./wd:Worker_Data/wd:Employment_Data', $NM)
                if ($null -ne $workerEmploymentData) {
                    $o.Active = $workerEmploymentData.Worker_Status_Data.Active -eq '1'
                }
                $workerJobData = $x.SelectSingleNode('./wd:Worker_Data/wd:Employment_Data/wd:Worker_Job_Data', $NM)
                if ($null -ne $workerJobData) {
                    $o.BusinessTitle = $workerJobData.Position_Data.Business_Title
                    # $o.JobProfileName = $workerJobData.Position_Data.Job_Profile_Summary_Data.Job_Profile_Name
                    $o.Location = $workerJobData.SelectNodes('./wd:Position_Data/wd:Business_Site_Summary_Data/wd:Name', $NM) | Select-Object -ExpandProperty InnerText -First 1 -ErrorAction SilentlyContinue
                   # $o.WorkSpace = $workerJobData.SelectNodes('./wd:Position_Data/wd:Work_Space__Reference/wd:ID[@wd:type="Location_ID"]', $NM) | Select-Object -ExpandProperty InnerText -First 1 -ErrorAction SilentlyContinue
                    $o.WorkerTypeReference = $workerJobData.SelectNodes('./wd:Position_Data/wd:Worker_Type_Reference/wd:ID[@wd:type="Employee_Type_ID"]', $NM) | Select-Object -ExpandProperty InnerText -First 1 -ErrorAction SilentlyContinue
                    $o.Manager = $workerJobData.Position_Data.Manager_as_of_last_detected_manager_change_Reference.ID |
                        Where-Object {$_.type -ne 'WID'} |
                            Select-Object @{Name='WorkerType';Expression={$_.type}}, @{Name='WorkerID';Expression={$_.'#text'}}
                    #$o.Company = $workerJobData.SelectNodes('./wd:Position_Organizations_Data/wd:Position_Organization_Data/wd:Organization_Data[wd:Organization_Type_Reference/wd:ID[@wd:type="Organization_Type_ID" and . = "COMPANY"]]', $NM) | Select-Object -ExpandProperty Organization_Name -First 1 -ErrorAction SilentlyContinue
                    #$o.BusinessUnit = $workerJobData.SelectNodes('./wd:Position_Organizations_Data/wd:Position_Organization_Data/wd:Organization_Data[wd:Organization_Type_Reference/wd:ID[@wd:type="Organization_Type_ID" and . = "BUSINESS_UNIT"]]', $NM) | Select-Object -ExpandProperty Organization_Name -First 1 -ErrorAction SilentlyContinue
                    #$o.Supervisory = $workerJobData.SelectNodes('./wd:Position_Organizations_Data/wd:Position_Organization_Data/wd:Organization_Data[wd:Organization_Type_Reference/wd:ID[@wd:type="Organization_Type_ID" and . = "SUPERVISORY"]]', $NM) | Select-Object -ExpandProperty Organization_Name -First 1 -ErrorAction SilentlyContinue
                }

                Write-Output $o
            }
        }
    }
}



