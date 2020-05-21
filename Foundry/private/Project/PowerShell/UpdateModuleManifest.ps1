function UpdateModuleManifest {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'medium')]

    param (

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Project]
        $Project

    )

    [System.IO.FileInfo] $moduleManifestPath = Join-Path -Path $Project.Paths.ProjectPath -ChildPath ($Project.Name + '.psd1')

    if (!(Test-Path -Path $moduleManifestPath.FullName -Type Leaf)) {

        throw "Unable to locate manifest for module $($Project.Name)!"

    }

    Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Building list of exported functions..."

    [string[]] $publicFunctionNames = (Get-ChildItem -File -Recurse -Path (Join-Path -Path $Project.Paths.ProjectPath -ChildPath 'public')).BaseName

    Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Found $($($publicFunctionNames | Measure-Object).Count) exported functions. They will be added to the manifest."

    Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): The following cmdlets will be exported: $($publicFunctionNames -join ', ')."

    Update-ModuleManifest -Path $moduleManifestPath -FunctionsToExport $publicFunctionNames -ErrorAction Stop

    Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Manifest updated"

}