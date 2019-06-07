<#
.SYNOPSIS
Combines all code hygeine checks and returns a [bool] if all checks were passed or not.

.DESCRIPTION
Combines all code hygeine checks and returns a [bool] if all checks were passed or not.

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

    begin {

    }

    process {

        $project = [Portfolio]::FindOneByNameExact($PsBoundParameters.Name)

        $project.TestIsReleaseReady()

    }

    end {

    }

}