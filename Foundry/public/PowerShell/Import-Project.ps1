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
function Import-Project {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'medium')]

    param (

    )

    dynamicParam {

        NewDynamicParameterDictionary -DynamicParameter $script:Scoped_DynamicParams_ProjectNames

    }

    process {

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($PSBoundParameters.Name): Importing by manifest file (Force, Global)..."

        try {

            $project = [Portfolio]::FindOneByNameExact($PsBoundParameters.Name)

            Import-Module -ErrorAction Stop -Force -Global $project.Paths.ManifestPath.FullName

        } catch {

            Write-Error $_

        }

        Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($PSBoundParameters.Name): Imported project."

    }

}