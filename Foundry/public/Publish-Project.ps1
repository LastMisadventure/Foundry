function Publish-Project {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'high', SupportsShouldProcess)]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ApiKey,

        [Parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [switch]
        $SkipHygieneCheck

    )

    dynamicParam {

        NewDynamicParameterDictionary -DynamicParameter $script:Scoped_DynamicParams_ProjectNames

    }

    process {

        try {

            $project = [Portfolio]::FindOneByNameExact($PsBoundParameters.Name)

            if ($PsCmdlet.ShouldProcess("$($project.Name): Publish to $($Scoped_ModuleConfig.NugetRepositoryName)?")) {

                if (!($SkipHygieneCheck.IsPresent)) {

                    if (!($project.TestIsReleaseReady())) {

                        Write-Error -ErrorRecord Stop -Message 'Project failed one or more hygiene checks.'

                    }

                }

            }

            $options = @{

                Path        = $project.ProjectPath

                NuGetApiKey = $ApiKey

                Repository  = $Scoped_ModuleConfig.NugetRepositoryName

                ErrorAction = 'Stop'

            }

            Publish-Module @options

        } catch {

            $PSCmdlet.ThrowTerminatingError($PSitem)

        }

    }

}