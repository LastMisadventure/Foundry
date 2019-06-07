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

        if ($Project.IsModule -eq $true) {

            $set = $Scoped_ModuleConfig.Build.Module.Files

        } else {

            $set = $Scoped_ModuleConfig.Build.Script.Files

        }

        $set | ForEach-Object {

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Creating project file: $($_)."

            New-Item -ItemType File -Name $_ -Path (Join-Path -Path $Project.RepositoryPath -ChildPath $Project.Name) | Out-Null

        }

        $taskResult = 'Success'

    } catch {

        Write-Error -Exception $_.Exception

    } finally {

        Write-Output $taskResult

    }

}