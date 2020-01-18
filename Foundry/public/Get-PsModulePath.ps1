<#
.SYNOPSIS
Gets 'machine' and 'user' scoped values for the environmental variable 'PSMODULEPATH' (`$env:PsModulePath`).

.DESCRIPTION
Gets 'machine' and 'user' scoped values for the environmental variable 'PSMODULEPATH' (`$env:PsModulePath`).

.EXAMPLE
Get-PsModulePath

Path                                                                    Scope
----                                                                    -----
C:\Program Files\WindowsPowerShell\Modules                              User
C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules\                     User
D:\alexc\documents\WindowsPowerShell\Modules                            User
C:\LocalRepos\Core                                                      User
C:\LocalRepos\Crucible                                                  User
C:\LocalRepos\Foundry                                                   User
C:\LocalRepos\Hermes                                                    User
C:\LocalRepos\Mythos                                                    User
C:\LocalRepos\SteamVent                                                 User
C:\LocalRepos\Vault                                                     User
C:\LocalRepos\VersionTest                                               User
C:\LocalRepos\Virtuoso                                                  User
C:\Modules\                                                             Machine
C:\Program Files\WindowsPowerShell\Modules                              Machine
C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules\                     Machine

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
