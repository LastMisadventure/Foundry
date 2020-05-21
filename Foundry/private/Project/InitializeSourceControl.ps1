function InitializeSourceControl {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Project]
        $Project

    )

    try {

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Initializing empty git repository at $($project.Paths.RepositoryPath.FullName)..."

        git init ($project.Paths.RepositoryPath.FullName) | Out-Null

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Initialized empty git repository at $($project.Paths.RepositoryPath.FullName)."

    } catch {

        $PSCmdlet.ThrowTerminatingError($PSItem)

    }

}