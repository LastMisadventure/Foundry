function UpdatePsModulePath {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

    )

    try {

        $ErrorActionPreference = 'Stop'

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Updating PsModulePath to include all PowerShell Module projects' module directory. This allows auto-import of modules to work correctly."

        $nonProjectModulesInPsModulePath = GetNonProjectModulesInPsModulePath | Select-Object -Unique

        $projectPowerShellModuleProjectPaths = ([Portfolio]::FindAll()).Paths.RepositoryPath.FullName

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: A total of $($($projectPowerShellModuleProjectPaths | Measure-Object).Count) modules will be added to PsModulePath."

        $newPsModulePathValue = ($nonProjectModulesInPsModulePath + $projectPowerShellModuleProjectPaths) -join ';'

        [System.Environment]::SetEnvironmentVariable('PSModulePath', $newPsModulePathValue, 'User')

        Write-Warning "[$($MyInvocation.MyCommand.Name)]: A new PowerShell session is required for changes to 'PsModulePath' environmental variable to take effect."

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Updated PsModulePath to include all Projects."

    } catch {

        $PSCmdlet.ThrowTerminatingError($PSItem)

    }

}