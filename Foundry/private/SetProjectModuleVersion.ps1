# PowerShell (as of 7.0) does not support SemVer 2.0, as it uses [system.version]. SemVer 2.0 was adopted by this module to have consistent(ish) versioning between PowerShell and Nuget-based repos.
function SetProjectModuleVersion {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $IncrementType,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        $Project

    )

    try {

        $projectManifestPath = Join-Path -Path $Project.Paths.ProjectPath -ChildPath ($Project.Name + '.psd1')

        $projectManifest = Import-PowerShellDataFile -Path $projectManifestPath -ErrorAction Stop

        $currentVersion = [System.Version] $projectManifest.ModuleVersion

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Current version is $currentVersion."

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

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): New version is $newVersion."

        Update-ModuleManifest -Path $projectManifestPath -ModuleVersion $newVersion

    } catch {

        Write-Error $_

    }

}