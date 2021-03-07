<#
.SYNOPSIS
Combines all code hygeine checks and returns [bool] if all checks were passed or not.

.DESCRIPTION
Combines all code hygeine checks and returns [bool] if all checks were passed or not.

.PARAMETER Name
The name of the project that will be targeted by this operation.

.EXAMPLE
Test-Project -Name ThisShouldBeWorkingNow

.NOTES
None
#>

function Test-Project {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [switch]
        $SkipCodeAnalzyer,

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [switch]
        $SkipTestSuite

    )

    dynamicParam {

        NewDynamicParameterDictionary -DynamicParameter $script:Scoped_DynamicParams_ProjectNames

    }

    process {

        $project = [Portfolio]::FindOneByNameExact($PsBoundParameters.Name)

        $codeAnalysis = 'Skipped'

        $testSuite = 'Skipped'

        if (!$SkipCodeAnalzyer.IsPresent) {

            $codeAnalysis = ($project.InvokeCodeAnalyzer()).Pass

        }

        if (!$SkipTestSuite.IsPresent) {

            $testSuite = ($project.InvokeTestSuite()).Pass

        }

        [PSCustomObject] [ordered] @{

            Name               = $project.Name

            CodeAnalysisPassed = $codeAnalysis

            TestSuitePassed    = $testSuite

        }

    }

}