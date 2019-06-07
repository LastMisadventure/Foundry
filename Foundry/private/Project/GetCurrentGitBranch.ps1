function GetCurrentGitBranch {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    [OutputType([string])]

    param (

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Project]
        $Project

    )

    Write-Output (posh-git\Get-GitStatus -gitDir $Project.GitPath).Branch

}