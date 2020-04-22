function CreateModuleManifest {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Project]
        $Project

    )

    try {

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Creating module manifest..."

        $splat = @{

            Description       = $Project.Description

            GUID              = (New-Guid).Guid

            RootModule        = ($($Project.Name) + '.psm1')

            FormatsToProcess  = 'Format.ps1xml'

            Path              = Join-Path -Path $Project.ProjectPath -ChildPath ($($Project.Name) + '.psd1')

            PowerShellVersion = ($PSVersionTable.PSVersion.ToString()).SubString(0, 3)

            Author            = $script:Scoped_ModuleConfig.AuthorFullName

            FunctionsToExport = @()

            VariablesToExport = @()

            AliasesToExport   = @()

            CmdletsToExport   = @()

        }

        if ($PSVersionTable.PSVersion -lt ([system.version] '6.0.0')) {

            $splat.Add('ClrVersion', $PSVersionTable.CLRVersion)

        }

        New-ModuleManifest @splat

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Created module manifest."

    } catch {

        $PSCmdlet.ThrowTerminatingError($PSItem)

    }

}