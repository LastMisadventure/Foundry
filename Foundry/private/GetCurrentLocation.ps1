function GetCurrentLocation {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'medium')]

    param (

    )

    $script:CurrentLocation = Get-Location

}