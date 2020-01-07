<#
.SYNOPSIS
Invokes the language-specific testing engine for the given project.

.DESCRIPTION
Invokes the language-specific testing engine for the given project.

.PARAMETER Name
The name of the project that will be targeted by this operation.

.EXAMPLE
Invoke-TestSuite ExampleProject

.NOTES
This cmdlet only deals with PowerShell tests (with Pester) at the momemnt. It also does not handle cases where a project uses more than one language. If this becomes an issue
I think it would be doable to evaluate each file and run the correct test suite based on extension.
#>
function Invoke-TestSuite {

    [CmdletBinding()]

    param (

    )

    dynamicParam {

        NewDynamicParameterDictionary -DynamicParameter $script:Scoped_DynamicParams_ProjectNames

    }

    process {

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($PSBoundParameters.Name): Invoking test suite for the project..."

        $project = [Portfolio]::FindOneByNameExact($PsBoundParameters.Name)

        $project.InvokeTestSuite()

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($PSBoundParameters.Name): Test suite has completed."

    }

}
