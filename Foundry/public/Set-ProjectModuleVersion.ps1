<#
.SYNOPSIS
Increments a module's version number (as stored in its manifest).

.DESCRIPTION
Increments a module's version number (as stored in its manifest). Review the guide below to know which value to increment:

* MAJOR - when you make incompatible API changes.

* MINOR - when you add functionality in a backwards compatible manner

* PATCH - when you make backwards compatible bug fixes.

.PARAMETER IncrementMinor
Increment the minor version.

.PARAMETER IncrementMajor
Increment the major version.

.EXAMPLE
ProjectModuleVersion Core -IncrementMinor

.LINK
https://semver.org/

.NOTES
PowerShell (as of 7.0) does not support SemVer 2.0, as it uses [system.version]. SemVer 2.0 was adopted by this module to have consistent(ish) versioning between PowerShell and Nuget-based repos.
#>

function Set-ProjectModuleVersion {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'high', SupportsShouldProcess)]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'IncrementMajor')]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Major', 'Minor', 'Patch')]
        [string]
        $IncrementType

    )

    dynamicParam {

        NewDynamicParameterDictionary -DynamicParameter $script:Scoped_DynamicParams_ProjectNames

    }

    process {

        if ($PSCmdlet.ShouldProcess('set the version of this module')) {

            try {

                $project = [Portfolio]::FindOneByNameExact($PsBoundParameters.Name)

                $projectManifestPath = Join-Path -Path $project.Paths.ProjectPath -ChildPath ($project.Name + '.psd1')

                $projectManifest = Import-PowerShellDataFile -Path $projectManifestPath

                $currentVersion = [System.Version] $projectManifest.ModuleVersion

                Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($project.Name): Current version is $currentVersion."

                $incrementedVersion = [PSCustomObject] [ordered] @{

                    'Major' = $currentVersion.Major

                    'Minor' = $currentVersion.Minor

                    'Patch' = $currentVersion.Build

                }

                switch ($IncrementType) {

                    'Major' {

                        $incrementedVersion.Major++

                    }

                    'Minor' {

                        $incrementedVersion.Minor++

                    }

                    'Patch' {

                        $incrementedVersion.Patch++

                    }

                }

                $newVersion = ([system.version]::New($incrementedVersion.Major, $incrementedVersion.Minor, $incrementedVersion.Patch).ToString())

                Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($project.Name): New version is $newVersion."

                Update-ModuleManifest -Path $projectManifestPath -ModuleVersion $newVersion

            } catch {

                $PSCmdlet.ThrowTerminatingError($PSitem)

            }

        }

    }

}