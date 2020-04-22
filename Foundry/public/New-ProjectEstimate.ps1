<#
.SYNOPSIS
Creates a three-point estimate.

.DESCRIPTION
Creates a three-point estimate.

.PARAMETER OptimisticEstimate
How long you think the task would take if all factors are optimal.

.PARAMETER NominalEstimate
How long you think the task would take given your real-world experience with similar activities and your current environment.

.PARAMETER PessimisticEstimate
How long you think the task would take if all factors are sub-optimal.

.EXAMPLE
New-ProjectEstimate -OptimisticEstimate 8 -NominalEstimate 17 -PessimisticEstimate 30

Duration Uncertainty
-------- -----------
    17.7         3.7

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
