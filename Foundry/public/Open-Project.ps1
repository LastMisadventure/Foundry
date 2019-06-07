<#
.SYNOPSIS
Opens a project in Visual Studio Code.

.DESCRIPTION
Opens a project in Visual Studio Code.

.EXAMPLE
Open-Project ExmapleProject

.NOTES

#>
function Open-Project {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

    )

    dynamicParam {

        NewDynamicParameterDictionary -DynamicParameter $script:Scoped_DynamicParams_ProjectNames

    }

    process {

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]:$($PSBoundParameters.Name): Opening project in default editor..."

        $project = [Portfolio]::FindOneByNameExact($PsBoundParameters.Name)

        $project.Open()

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]:$($PSBoundParameters.Name): Opened project."

    }

}
