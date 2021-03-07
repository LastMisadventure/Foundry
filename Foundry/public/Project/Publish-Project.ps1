function Publish-Project {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'high', SupportsShouldProcess)]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Major', 'Minor', 'Patch')]
        [string]
        $IncrementType,

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [switch]
        $SkipHygieneCheck

    )

    dynamicParam {

        NewDynamicParameterDictionary -DynamicParameter $script:Scoped_DynamicParams_ProjectNames

    }

    begin {

        GetCurrentLocation

    }

    process {

        try {

            $project = [Portfolio]::FindOneByNameExact($PsBoundParameters.Name)

            if (!($PsCmdlet.ShouldProcess("$($project.Name): Publish to $($Scoped_ModuleConfig.NugetRepositoryName)?"))) {

                return

            }

            if (!($SkipHygieneCheck.IsPresent)) {

                if (!($project.TestIsReleaseReady())) {

                    Write-Error -ErrorRecord Stop -Message 'Project failed one or more hygiene checks.'

                }

            }

            SetProjectModuleVersion -IncrementType $IncrementType -Project $project -ErrorAction Stop

            $options = @{

                Path        = $project.Paths.ProjectPath

                NuGetApiKey = (GetApiKeyFromVault -RepositoryName $Scoped_ModuleConfig.NugetRepositoryName)

                Repository  = $Scoped_ModuleConfig.NugetRepositoryName

                ErrorAction = 'Stop'

            }

            Publish-Module @options

            Set-Location -Path $project.Paths.RepositoryPath -ErrorAction Stop

            git.exe push | Out-Null

        } catch {

            Write-Error $_

        } finally {

            ResetToCurrentLocation

        }

    }

}