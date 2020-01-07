<#
.SYNOPSIS
Gets a list of projects. Projects returned by this cmdlet can be piped to other project-related cmdlets.

.DESCRIPTION
Gets a list of projects. Projects returned by this cmdlet can be piped to other project-related cmdlets.

.PARAMETER Name
Wildcard. Returns projects that match this value.

.PARAMETER Language
Returns projects that (primarily) use this language.

.EXAMPLE
Get-Project Foundry

Name    Branch   RepositoryPath
----    ------   --------------
Foundry (master) C:\LocalRepos\Foundry


.NOTES

#>
function Get-Project {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low', DefaultParameterSetName = 'GetAll')]

    param (

        [Parameter(Mandatory, ValueFromPipeline, Position = 0, ParameterSetName = 'GetProjectByNameLike')]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Name

    )

    process {

        if ($PSCmdlet.ParameterSetName -eq 'GetAll') {

            [Portfolio]::FindAll()

        }

        if ($PSCmdlet.ParameterSetName -eq 'GetProjectByNameLike') {

            $Name | ForEach-Object {

                [Portfolio]::FindByNameFuzzy($_)

            }

        }

    }

}