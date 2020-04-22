function CreateRepositoryDirectory {

    [CmdletBinding(PositionalBinding)]

    [OutputType([string])]

    param (

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Project]
        $Project

    )

    $taskResult = 'Fail'

    try {

        $splat = @{

            Name = $Project.Name

            Path = $script:Scoped_ModuleConfig.LocalRepository

            Type = 'Directory'

        }

        New-Item @splat | Out-Null

        $splat = @{

            Name = ".vscode"

            Path = $Project.RepositoryPath

            Type = 'Directory'

        }

        New-Item @splat | Out-Null

        $taskResult = 'Success'

    } catch {

        $PSCmdlet.ThrowTerminatingError($PSItem)

    } finally {

        Write-Output $taskResult

    }

}