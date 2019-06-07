<#
.SYNOPSIS
Creates a selection of build names.

.DESCRIPTION
Creates a selection of build names.

.PARAMETER AdditionalGenerationCount
Specify how many additional choices choices should be generated.

.PARAMETER Theme
Generated names follow a particular theme:
Generic: All theme elements.
IT: Only 'information technologies'-related words are used to generate choices.

.EXAMPLE
Get-RandomReleaseName

Exposed Visage of the Faithless

.NOTES
None.
#>
function Get-RandomReleaseName {

    [CmdletBinding(ConfirmImpact = 'low')]

    param (

        [Parameter(ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [int]
        $AdditionalGenerationCount,

        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateSet("IT", "Generic")]
        [string]
        $Theme = 'Generic'

    )

    begin {

        $GenerationData = @{

            DataSource = Import-Csv -Path (Join-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -ChildPath "NamerSource.csv") -ErrorAction Stop
            Parts      = @{1 = "PrefixParts"; 2 = "ObjectParts"; 4 = "SuffixParts" }
            ThemeMap   = @{"IT" = 16 ; "Generic" = 8 }

        }

    }

    process {

        $GenerationData.Add('Theme', $Theme)

        $defaultGenerationCount = 0
        $totalGenerationCount = 0

        if ($PSBoundParameters.ContainsKey('AdditionalGenerationCount')) {

            $totalGenerationCount = $AdditionalGenerationCount + $defaultGenerationCount

        }

        $defaultGenerationCount..$totalGenerationCount | ForEach-Object { NewRandomName $GenerationData }

    }

}