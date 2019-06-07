function UpdateModuleManifest {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'medium')]

    param (

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Project]
        $Project

    )

    [System.IO.FileInfo] $_moduleManifestPath = Join-Path -Path $Project.ProjectPath -ChildPath ($Project.Name + '.psd1')

    if (!(Test-Path -Path $_moduleManifestPath.FullName -Type Leaf)) {

        throw "Unable to locate manifest for module $($Project.Name)!"

    }

    Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Building list of exported functions..."

    [string[]] $_publicFunctionNames = (Get-ChildItem -File -Recurse -Path (Join-Path -Path $Project.ProjectPath -ChildPath 'public')).BaseName

    Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Found $($($_publicFunctionNames | Measure-Object).Count) exported functions. They will be added to the manifest."

    Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): The following cmdlets will be exported: $($_publicFunctionNames -join ', ')."

    Update-ModuleManifest -Path $_moduleManifestPath -FunctionsToExport $_publicFunctionNames -ErrorAction Stop

    Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Manifest updated"

}