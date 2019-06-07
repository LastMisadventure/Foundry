function TestIfGitUsed {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    [OutputType([bool])]

    param (

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Project]
        $Project

    )

    Write-Output (Test-Path -Path $Project.GitPath -PathType Container)

}