<#
.SYNOPSIS
Gets 'machine' and 'user' scoped values for the environmental variable 'PSMODULEPATH'.

.DESCRIPTION
Gets 'machine' and 'user' scoped values for the environmental variable 'PSMODULEPATH'.

.EXAMPLE
Update-PsModulePath

.NOTES

#>
function Get-PsModulePath {

    [CmdletBinding(ConfirmImpact = 'low', SupportsShouldProcess)]

    param (

    )

    if ($PSCmdlet.ShouldProcess("Get the current PSMODULEPATH value")) {

        try {

            $scopes = 'User', 'Machine'

            $scopes | ForEach-Object {

                $currentScope = $_

                ([System.Environment]::GetEnvironmentVariable("PSModulePath", $currentScope)) -split ';' | ForEach-Object {

                    [PSCustomObject] [ordered] @{

                        Path  = $_

                        Scope = $currentScope

                    }

                }

            }

        } catch {

            $PSCmdlet.ThrowTerminatingError($PSitem)

        }

    }

}
