<#
.SYNOPSIS
Gets a list of projects. Projects returned by this cmdlet can be piped to other project-related cmdlets.

.DESCRIPTION
Gets a list of projects. Projects returned by this cmdlet can be piped to other project-related cmdlets.

.PARAMETER Name
Wildcard. Returns projects that match this value.

.PARAMETER Refresh
Forcibly refreshes the project list.

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
        $Name,

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [switch]
        $Refresh

    )

    process {

        if ($Refresh.IsPresent) {

            [Portfolio]::LoadFromRepositoryDirectory()

        }

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