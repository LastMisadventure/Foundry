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

        Get-ChildItem -File -Path $PSScriptRoot\Templates | Copy-Item -Recurse -Destination (Join-Path -Path $project.Paths.RepositoryPath -ChildPath '.vscode')

        $taskResult = 'Success'

    } catch {

        $PSCmdlet.ThrowTerminatingError($PSItem)

    } finally {

        Write-Output $taskResult

    }

}