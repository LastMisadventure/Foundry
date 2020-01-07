<#
.SYNOPSIS
Combines all code hygeine checks and returns [bool] if all checks were passed or not.

.DESCRIPTION
Combines all code hygeine checks and returns [bool] if all checks were passed or not.

.PARAMETER Name
The name of the project that will be targeted by this operation.

.EXAMPLE
Test-ProjectReadyForRelease -Name ThisShouldBeWorkingNow

.NOTES
None
#>

function Test-ProjectReadyForRelease {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

    )

    dynamicParam {

        NewDynamicParameterDictionary -DynamicParameter $script:Scoped_DynamicParams_ProjectNames

    }

    process {

        $project = [Portfolio]::FindOneByNameExact($PsBoundParameters.Name)

        $project.TestIsReleaseReady()

    }

}