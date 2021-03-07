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
# Create a new module. By default, a git repository is created and the project is automatically opened in VSCode.

New-Project -Name BeExceptional -Type Module -Verbose

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
        [string]
        $Description,

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [switch]
        $SkipOpeningNewProject,

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [switch]
        $SkipSourceControlInit

    )

    process {

        if ($PsCmdlet.ShouldProcess("Create a project named '$($Name)'.")) {

            CreateNewProject $PSBoundParameters

        }

    }

}