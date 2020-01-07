<#
.SYNOPSIS
Removes a Project from disk - this will completely delete all Project files.

.DESCRIPTION
Removes a Project from disk - this will completely delete all Project files.

.PARAMETER Name
The name of the project that will be targeted by this operation.

.EXAMPLE
Remove-Project -Name IShouldNotHaveDoneThat

.NOTES
None.
#>

function Remove-Project {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'high', SupportsShouldProcess)]

    param (

    )

    dynamicParam {

        NewDynamicParameterDictionary -DynamicParameter $script:Scoped_DynamicParams_ProjectNames

    }

    begin {

    }

    process {

        $shouldProcessMessage = 'remove project - this will delete all project files from the disk'

        $shouldProcessTarget = $PSBoundParameters.Name

        if ($PSCmdlet.ShouldProcess($shouldProcessMessage, $shouldProcessTarget)) {

            try {

                $project = [Portfolio]::FindOneByNameExact($PsBoundParameters.Name)

                $project.RepositoryPath.Delete($true)

            } catch {

                $PSCmdlet.ThrowTerminatingError($PSitem)

            }
        }
    }

    end {

        UpdatePsModulePath

        [Portfolio]::LoadFromRepositoryDirectory()

    }

}