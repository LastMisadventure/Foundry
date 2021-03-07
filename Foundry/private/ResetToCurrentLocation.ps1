function ResetToCurrentLocation {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'medium')]

    param (

    )

    Set-Location $script:CurrentLocation

}