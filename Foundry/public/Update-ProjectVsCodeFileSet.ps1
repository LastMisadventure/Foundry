<#
.SYNOPSIS
Updates workspace snippets, debug settings, and tasks.

.DESCRIPTION
Updates workspace snippets, debug settings, and tasks.

.PARAMETER Name
The name of the project that will be targeted by this operation.

.EXAMPLE
Update-ProjectVsCodeFileSet -Name Foundry

.NOTES
General notes
#>

function Update-ProjectVsCodeFileSet {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'medium')]

    param (

    )

    dynamicParam {

        NewDynamicParameterDictionary -DynamicParameter $script:Scoped_DynamicParams_ProjectNames

    }

    begin {

    }

    process {

        CopyVsCodeFileSet -Project ([Portfolio]::FindOneByNameExact($PsBoundParameters.Name)) | Out-Null

    }

    end {

    }

}