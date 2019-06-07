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

    $pesterResult = Invoke-Pester @splat

    $codeHygieneResult = [CodeHygieneResult]::New()

    $codeHygieneResult.Project = $Project.Name
    $codeHygieneResult.Type = 'TestSuite'
    $codeHygieneResult.Clean = $pesterResult.FailedCount -eq 0
    $codeHygieneResult.Defects = $pesterResult.TestResult.Describe

    Write-Output $codeHygieneResult

}