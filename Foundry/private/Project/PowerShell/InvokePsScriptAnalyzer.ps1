function InvokePsScriptAnalyzer {

    [CmdletBinding(ConfirmImpact = 'low', PositionalBinding)]

    param (

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Project]
        $Project

    )

    $splat = @{

        Verbose  = $false

        Severity = 'Error', 'Warning'

        Recurse  = $true

        Path     = $Project.ProjectPath

    }

    $analyzerResult = Invoke-ScriptAnalyzer @splat

    $codeHygieneResult = [CodeHygieneResult]::New()

    $codeHygieneResult.Type = 'CodeAnalysis'

    $codeHygieneResult.Project = $Project.Name

    $codeHygieneResult.Clean = $false

    if ($null -eq $codeHygieneResult.Defects) {

        $codeHygieneResult.Clean = $true

    } else {

        $codeHygieneResult.Defects = $analyzerResult.ScriptName

    }

    Write-Output $codeHygieneResult

}