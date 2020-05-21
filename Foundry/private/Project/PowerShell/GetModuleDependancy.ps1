function GetModuleDepandancy {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'medium')]

    param (

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [project]
        $Project

    )

    try {

        $projectManifest = Import-PowerShellDataFile -Path $project.Paths.ManifestPath

        $dependancies = [PSCustomObject] [ordered] @{

        }

        $hasDependacies = $null -ne ($projectManifest | Select-Object -Property 'RequiredModules' | Select-Object -ExpandProperty 'RequiredModules')

        if ($hasDependacies) {

            Add-Member -InputObject $dependancies -PassThru -MemberType NoteProperty -Name 'RequiredModules' -Value $projectManifest.RequiredModules

        }

    } catch {

        $PSCmdlet.ThrowTerminatingError($PSitem)

    }

}
