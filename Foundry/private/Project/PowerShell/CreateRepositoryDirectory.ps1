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

        $taskResult = 'Success'

    } catch {

        Write-Error -Exception $_.Exception

    } finally {

        Write-Output $taskResult

    }

}