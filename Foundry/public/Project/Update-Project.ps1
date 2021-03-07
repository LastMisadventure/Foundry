<#
.SYNOPSIS
Updates workspace snippets, debug settings, and tasks.

.DESCRIPTION
Updates workspace snippets, debug settings, and tasks.

.PARAMETER Name
The name of the project that will be targeted by this operation.

.EXAMPLE
Update-Project -Name Foundry

.NOTES
General notes
#>

function Update-Project {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

    )

    dynamicParam {

        NewDynamicParameterDictionary -DynamicParameter $script:Scoped_DynamicParams_ProjectNames

    }

    process {

        $project = [Portfolio]::FindOneByNameExact($PsBoundParameters.Name)

        CopyVsCodeFileSet -Project $project | Out-Null

        $project.UpdateManifest()

    }

}