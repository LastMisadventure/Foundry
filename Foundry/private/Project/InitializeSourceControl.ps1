function InitializeSourceControl {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Project]
        $Project

    )

    Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Initializing empty git repository at $($Project.RepositoryPath.FullName)..."

    git init ($Project.RepositoryPath.FullName) | Out-Null

    Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Initialized empty git repository at $($Project.RepositoryPath.FullName)."

}