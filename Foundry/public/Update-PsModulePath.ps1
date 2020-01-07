<#
.SYNOPSIS
Updates the `PsModulePath` environmental variable to contain all PowerShell module projects.
This faciliates proper module auto-loading.

.DESCRIPTION
Updates the `PsModulePath` environmental variable (User scope) to contain all PowerShell module projects.
This faciliates proper module auto-loading.

.EXAMPLE
Update-PsModulePath

.NOTES

#>
function Update-PsModulePath {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'medium', SupportsShouldProcess)]

    param (

    )

    process {

        if ($PSCmdlet.ShouldProcess('update PsModulePath environmental variable')) {

            [Portfolio]::UpdatePsModulePath()

        }

    }

}
