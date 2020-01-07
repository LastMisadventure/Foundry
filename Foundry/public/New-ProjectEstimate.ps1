<#
.SYNOPSIS
Creates a three-point estimate.

.DESCRIPTION
Creates a three-point estimate.

.PARAMETER OptimisticEstimate
How long you think the task would take if all factors are optimal.

.PARAMETER NominalEstimate
Parameter description

.PARAMETER PessimisticEstimate
Parameter description

.EXAMPLE
An example

.NOTES
General notes
#>

function New-ProjectEstimate {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low', HelpUri = 'https://en.wikipedia.org/wiki/Three-point_estimation')]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [decimal]
        $OptimisticEstimate,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [decimal]
        $NominalEstimate,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [decimal]
        $PessimisticEstimate
    )

    process {

        try {

            $estimatedDuration = ($OptimisticEstimate + (4 * $NominalEstimate) + $PessimisticEstimate) / 6

            $uncertainty = ($PessimisticEstimate - $OptimisticEstimate) / 6

            [PSCustomObject] [ordered] @{

                Duration    = [math]::Round($estimatedDuration, 1)

                Uncertainty = [math]::Round($uncertainty, 1)

            }

        } catch {

            $PSCmdlet.ThrowTerminatingError($PSitem)

        }

    }

}
