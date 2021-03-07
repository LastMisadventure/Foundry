<#
.SYNOPSIS
Invokes applicable code analysis suites (based on which languages are used) for a given project.

.DESCRIPTION
Invokes applicable code analysis suites (based on which languages are used) for a given project.

.PARAMETER Name
The name of the project to target in this operation.

.EXAMPLE
Invoke-CodeAnalyzer ExampleProject

.NOTES
#>
function Invoke-CodeAnalyzer {

    [CmdletBinding(ConfirmImpact = 'low', SupportsShouldProcess, PositionalBinding)]

    param ()

    DynamicParam {

        NewDynamicParameterDictionary -DynamicParameter $script:Scoped_DynamicParams_ProjectNames

    }

    process {

        if ($PsCmdlet.ShouldProcess($PsBoundParameters.Name, 'Perform PSScriptAnalyzer Analysis')) {

            try {

                Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($PSBoundParameters.Name): Invoking code analyzer for the project..."

                $project = [Portfolio]::FindOneByNameExact($PsBoundParameters.Name)

                $project.InvokeCodeAnalyzer()

                Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($PSBoundParameters.Name): Analysis complete."

            } catch {

                Write-Error $_

            }

        }

    }

}
