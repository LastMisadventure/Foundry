<#
.SYNOPSIS
Creates a new PowerShell project.

.DESCRIPTION
Creates a new PowerShell project.

.PARAMETER Name
The new project's name; this will also be the name of the git repository.

.PARAMETER Type
Choose between a 'Module' or a 'Script':
- Module: A complete PowerShell module with a main psm1 file, a manifest, and other items.
- Script: A basic file structure intended for a single script with supporting private functions.

.PARAMETER SkipOpeningNewProject
The new project will not be opened in Visual Studio Code after creation.

.PARAMETER SkipSourceControlInit
The new project will not be intialized in git.

.EXAMPLE
An example

.NOTES
General notes
#>

function New-Project {

    [CmdletBinding(ConfirmImpact = 'low', PositionalBinding, SupportsShouldProcess)]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Module', 'Script')]
        [string]
        $Type,

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [switch]
        $SkipOpeningNewProject,

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [switch]
        $SkipSourceControlInit

    )

    begin {

    }

    process {

        $spOperation = "Create a new project named '$($Name)'."

        if ($PsCmdlet.ShouldProcess($spOperation)) {

            Write-Output ([ProjectFactory]::Create($PSBoundParameters))

        }
    }

    end {

    }

}