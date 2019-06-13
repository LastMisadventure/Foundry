function CopyVsCodeFileSet {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Project]
        $Project

    )

    $taskResult = 'Fail'

    try {

        Get-ChildItem -File -Path $PSScriptRoot\Templates | Copy-Item -Recurse -Destination (Join-Path -Path $Project.RepositoryPath -ChildPath '.vscode')

        $taskResult = 'Success'

    } catch {

        Write-Error -Exception $_.Exception

    } finally {

        Write-Output $taskResult

    }

}