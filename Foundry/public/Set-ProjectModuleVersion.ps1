<#
.SYNOPSIS
Increments a module's version number (as stored in its manifest).

.DESCRIPTION
Increments a module's version number (as stored in its manifest).

.PARAMETER IncrementMinor
Increment the minor version.

.PARAMETER IncrementMajor
Increment the major version.

.EXAMPLE
ProjectModuleVersion Core -IncrementMinor

.NOTES
General notes
#>

function Set-ProjectModuleVersion {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'medium', SupportsShouldProcess)]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'IncrementMinor')]
        [ValidateNotNullOrEmpty()]
        [switch]
        $IncrementMinor,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'IncrementMajor')]
        [ValidateNotNullOrEmpty()]
        [switch]
        $IncrementMajor

    )

    dynamicParam {

        NewDynamicParameterDictionary -DynamicParameter $script:Scoped_DynamicParams_ProjectNames

    }

    process {

        if ($PSCmdlet.ShouldProcess('set the version of this module')) {

            try {

                $project = [Portfolio]::FindOneByNameExact($PsBoundParameters.Name)

                $projectManifestPath = Join-Path -Path $project.ProjectPath -ChildPath ($project.Name + '.psd1')

                $projectManifest = Import-PowerShellDataFile -Path $projectManifestPath

                $currentVersion = [System.Version] $projectManifest.ModuleVersion

                Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($project.Name): Current version is $currentVersion."

                $incrementedVersion = [PSCustomObject] [ordered] @{

                    Major = $currentVersion.Major

                    Minor = $currentVersion.Minor

                }

                if ($IncrementMajor.IsPresent) {

                    $incrementedVersion.Major++

                }

                if ($IncrementMinor.IsPresent) {

                    $incrementedVersion.Minor++

                }

                $newVersion = ([system.version]::New($incrementedVersion.Major, $incrementedVersion.Minor).ToString())

                Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($project.Name): New version is $newVersion."

                Update-ModuleManifest -Path $projectManifestPath -ModuleVersion $newVersion

            } catch {

                $PSCmdlet.ThrowTerminatingError($PSitem)

            }

        }

    }

}