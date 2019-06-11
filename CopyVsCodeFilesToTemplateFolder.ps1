[CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

param (

)

Get-ChildItem -File -Path $PSScriptRoot\.vscode | Copy-Item -Destination $PSScriptRoot\Foundry\private\VsCode\Templates -Force