function GetApiKeyFromVault {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'medium')]

    param (

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $RepositoryName

    )

    try {

        Write-Ouptut (Vault\Get-VaultEntry -Resource $RepositoryName -IncludePassword -Force -ErrorAction Stop).Password

    } catch {

        Write-Error $_

    }

}