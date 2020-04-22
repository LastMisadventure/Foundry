function InvokePsTestSuite {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Project]
        $Project
    )

    $splat = @{

        Show     = 'None'

        PassThru = $true

        Strict   = $true

        Script   = $Project.TestPath

    }

    Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Running Pester tests..."

    $pesterResult = Invoke-Pester @splat

    Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): RanPester tests."

    $codeHygieneResult = [CodeHygieneResult]::New()

    $codeHygieneResult.Project = $Project.Name

    $codeHygieneResult.Type = 'TestSuite'

    $codeHygieneResult.Pass = $pesterResult.FailedCount -eq 0

    $failedTests = $pesterResult.TestResult | Where-Object { $_.Passed -ne $true } | Select-Object -ExpandProperty Describe

    $codeHygieneResult.Defects = $failedTests

    Write-Output $codeHygieneResult

}