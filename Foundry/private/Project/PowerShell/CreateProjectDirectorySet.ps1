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

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Creating module directory: $($_)."

            New-Item -ItemType Directory -Name $_ -Path (Join-Path -Path $Project.RepositoryPath -ChildPath $Project.Name) | Out-Null

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Created module directory."

        }

        $taskResult = 'Success'

    } catch {

        $PSCmdlet.ThrowTerminatingError($PSItem)

    } finally {

        Write-Output $taskResult

    }

}