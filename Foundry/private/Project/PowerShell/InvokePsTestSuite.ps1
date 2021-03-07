function InvokePsTestSuite {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Project]
        $Project

    )

    $configuration = [PesterConfiguration]::Default

    $configuration.Output.Verbosity.Value = 'none'

    $configuration.Run.Path.Value = $project.Paths.TestPath.FullName

    $configuration.Run.PassThru.Value = $true

    Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Running Pester tests..."

    $result = Invoke-Pester -Configuration $configuration

    Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Ran Pester tests."

    $codeHygieneResult = [CodeHygieneResult]::New()

    $codeHygieneResult.Project = $Project.Name

    $codeHygieneResult.Type = 'TestSuite'

    $codeHygieneResult.Pass = $result.FailedCount -eq 0

    $codeHygieneResult.Defects = $result.Failed | Select-Object -ExpandProperty ExpandedPath

    Write-Output $codeHygieneResult

}