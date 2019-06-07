function CreateModuleManifest {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'medium')]

    param (

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Project]
        $Project

    )

    $splat = @{

        GUID              = (New-Guid).Guid
        RootModule        = ($($Project.Name) + '.psm1')
        FormatsToProcess  = 'Format.ps1xml'
        Path              = Join-Path -Path $Project.ProjectPath -ChildPath ($($Project.Name) + '.psd1')
        PowerShellVersion = ($PSVersionTable.PSVersion.ToString()).SubString(0, 3)
        ClrVersion        = $PSVersionTable.CLRVersion
        Author            = $script:Scoped_ModuleConfig.AuthorFullName
        FunctionsToExport = @()
        VariablesToExport = @()
        AliasesToExport   = @()
        CmdletsToExport   = @()

    }

    New-ModuleManifest @splat

}