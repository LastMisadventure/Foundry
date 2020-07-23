<#
.SYNOPSIS
Imports the given project. It's imported with the `Force` and `Global` switches.

.DESCRIPTION
Imports the given project. It's imported with the `Force` and `Global` switches.

.EXAMPLE
Import-ProjectModule <ProjectName>

.NOTES
General notes
#>
function Import-ProjectModule {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'medium')]

    param (

    )

    dynamicParam {

        NewDynamicParameterDictionary -DynamicParameter $script:Scoped_DynamicParams_ProjectNames

    }

    process {

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($PSBoundParameters.Name): Importing by manifest file (Force, Global)..."

        $project = [Portfolio]::FindOneByNameExact($PsBoundParameters.Name)

        Import-Module -ErrorAction Stop -Force -Global $project.Paths.ManifestPath.FullName

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($PSBoundParameters.Name): Imported project."

    }

}