function GetNonProjectModulesInPsModulePath {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    [OutputType([string[]])]

    param (

    )

    $regexString = $script:Scoped_ModuleConfig.LocalRepository.Replace('\', '\\')

    Write-Output ($env:PSModulePath -split ';' | Where-Object { $_ -notmatch $regexString })

}