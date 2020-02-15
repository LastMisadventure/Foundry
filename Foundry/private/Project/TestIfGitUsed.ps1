function TestIfGitUsed {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    [OutputType([bool])]

    param (

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Project]
        $Project

    )

    try {

        Write-Output (Test-Path -Path $Project.GitPath -PathType Container)

    } catch {

        $PSCmdlet.ThrowTerminatingError($PSItem)

    }

}