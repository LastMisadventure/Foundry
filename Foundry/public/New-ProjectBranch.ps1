<#
.SYNOPSIS
Creates new branch for the targeted Project.

.DESCRIPTION
Creates new branch for the targeted Project.

.PARAMETER BranchName
The new branch's name.

.PARAMETER Type
What type of branch it is.

.EXAMPLE
New-ProjectBranch -Type Feature -BranchName "Cool1 ddddAA" -Name test05

.NOTES
Spaces are automatically converted to underscores. Uppercase letters are automatically converted to lowercase.
#>
function New-ProjectBranch {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]
        $BranchName,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Custom', 'Feature', 'HotFix')]
        [string]
        $Type

    )

    dynamicParam {

        NewDynamicParameterDictionary -DynamicParameter $script:Scoped_DynamicParams_ProjectNames

    }

    begin {

        $currentWorkingPath = Get-Location

    }

    process {

        try {

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]:$($PSBoundParameters.Name): Creating a new $($Type) branch..."

            $project = [Portfolio]::FindOneByNameExact($PsBoundParameters.Name)

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]:$($PSBoundParameters.Name): Opened project."

            Set-Location -Path $project.Paths.RepositoryPath -ErrorAction Stop

            $fullBranchName = $Type.ToLower() + '/' + $BranchName.Replace(' ', '_').ToLower()

            git.exe checkout -b $fullBranchName | Out-Null

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]:$($PSBoundParameters.Name): Created a new $($Type) branch."

        } catch {

            $PSCmdlet.ThrowTerminatingError($PSitem)

        } finally {

            Set-Location -Path $currentWorkingPath

        }

    }

    end {

        Set-Location -Path $currentWorkingPath

    }

}