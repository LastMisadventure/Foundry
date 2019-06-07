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
function Update-PsModuleManifest {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low', SupportsShouldProcess)]

    param (

    )

    dynamicParam {

        NewDynamicParameterDictionary -DynamicParameter $script:Scoped_DynamicParams_ProjectNames

    }

    begin {

    }

    process {

        $shouldProcessMessage = 'update module manifest file'
        $shouldProcessTarget = $PSBoundParameters.Name

        if ($PSCmdlet.ShouldProcess($shouldProcessMessage, $shouldProcessTarget)) {

            $project = [Portfolio]::FindOneByNameExact($PsBoundParameters.Name)

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($_project.Name): Updating manifest..."

            $project.UpdateModuleManifest()

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($_project.Name): Updated manifest."

        }

    }

    end {

    }

}
