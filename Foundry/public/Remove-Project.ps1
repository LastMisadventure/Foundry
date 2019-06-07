<#
.SYNOPSIS
Removes a Project from disk - this will completely delete all Project files.

.DESCRIPTION
Removes a Project from disk - this will completely delete all Project files.

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

                UpdatePsModulePath

                [Portfolio]::LoadFromRepositoryDirectory()

            } catch {

                Write-Error -ErrorAction Stop -Exception $_.Exception

            }
        }
    }

    end {

    }

}