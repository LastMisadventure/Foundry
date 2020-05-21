function CreateProjectFileSet {

    [CmdletBinding(PositionalBinding)]

    param (

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Project]
        $Project

    )

    try {

        $taskResult = 'Fail'

        $set = $Scoped_ModuleConfig.Build.Module.Files

        $set | ForEach-Object {

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Creating project file: $($_)..."

            New-Item -ItemType File -Name $_ -Path (Join-Path -Path $project.Paths.RepositoryPath -ChildPath $Project.Name) | Out-Null

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Created project file."

        }

        $taskResult = 'Success'

    } catch {

        $PSCmdlet.ThrowTerminatingError($PSItem)

    } finally {

        Write-Output $taskResult

    }

}