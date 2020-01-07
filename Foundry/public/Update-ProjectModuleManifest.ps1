<#
.SYNOPSIS
Updates a PowerShell module project's manifest file.

.DESCRIPTION
Updates a PowerShell module project's manifest file.

* Replaces the `FunctionsToExport` array with an array of the current functions in the project's 'public' folder.

.EXAMPLE
Update-PsModuleManifest ExamplePowerShellModuleProject

.NOTES
Currently, the only thing updated is the list of exported functions. Only functions in the project's 'public' folder will be updated.
#>
function Update-ProjectModuleManifest {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low', SupportsShouldProcess)]

    param (

    )

    dynamicParam {

        NewDynamicParameterDictionary -DynamicParameter $script:Scoped_DynamicParams_PsModuleProjectNames

    }

    process {

        if ($PSCmdlet.ShouldProcess('update module manifest file', $PSBoundParameters.Name)) {

            $project = [Portfolio]::FindOneByNameExact($PsBoundParameters.Name)

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($project.Name): Updating manifest..."

            $project.UpdateManifest()

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($project.Name): Updated manifest."

        }

    }

}
