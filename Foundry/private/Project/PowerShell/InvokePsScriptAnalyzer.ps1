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

        Path     = $Project.Paths.ProjectPath

    }

    Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Analyzing code..."

    $analyzerResult = Invoke-ScriptAnalyzer @splat

    Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Analyzed code."

    $codeHygieneResult = [CodeHygieneResult]::New()

    $codeHygieneResult.Type = 'CodeAnalysis'

    $codeHygieneResult.Project = $Project.Name

    $codeHygieneResult.Pass = $false

    if ($null -eq $codeHygieneResult.Defects) {

        $codeHygieneResult.Pass = $true

    } else {

        $codeHygieneResult.Defects = $analyzerResult.ScriptName

    }

    Write-Output $codeHygieneResult

}