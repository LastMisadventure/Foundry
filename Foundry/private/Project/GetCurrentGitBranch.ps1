function GetCurrentGitBranch {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    [OutputType([string])]

    param (

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Project]
        $Project

    )

    try {

        $currentBranch = posh-git\Get-GitStatus -gitDir $project.Paths.gitPath | Select-Object -ExpandProperty 'Branch'

        Write-Output $currentBranch

    } catch {

        $PSCmdlet.ThrowTerminatingError($PSItem)

    }

}