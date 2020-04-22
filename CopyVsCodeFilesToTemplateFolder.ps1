[CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

param (

)

try {

    Get-ChildItem -File -Path $PSScriptRoot\.vscode -ErrorAction Stop | Copy-Item -Destination $PSScriptRoot\Foundry\private\VsCode\Templates -Force -ErrorAction Stop

} catch {

    $PSCmdlet.ThrowTerminatingError($PSitem)

}