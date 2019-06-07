function CreateProjectDirectorySet {

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

            $directorySet = $Scoped_ModuleConfig.Build.Module.Directories

        } else {

            $directorySet = $Scoped_ModuleConfig.Build.Script.Directories

        }

        $directorySet | ForEach-Object {

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Creating module directory: $($_)."

            New-Item -ItemType Directory -Name $_ -Path (Join-Path -Path $Project.RepositoryPath -ChildPath $Project.Name) | Out-Null

        }

        $taskResult = 'Success'

    } catch {

        Write-Error -Exception $_.Exception

    } finally {

        Write-Output $taskResult

    }

}