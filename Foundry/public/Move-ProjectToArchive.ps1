<#
.SYNOPSIS
Zips a project to the configured archive directory. If the zip is successful, the project is removed.

.DESCRIPTION
Zips a project to the configured archive directory. If the zip is successful, the project is removed.

.EXAMPLE
Move-ProjectToArchive -Name Core

.NOTES
General notes
#>

function Move-ProjectToArchive {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'medium')]

    param (

    )

    dynamicParam {

        NewDynamicParameterDictionary -DynamicParameter $script:Scoped_DynamicParams_ProjectNames

    }

    process {

        try {

            $project = [Portfolio]::FindOneByNameExact($PsBoundParameters.Name)

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($project.Name) Compressing project directory to $($script:Scoped_ModuleConfig.RepositoryArchive)..."

            Compress-Archive -Path $project.RepositoryPath -DestinationPath (Join-Path -Path $script:Scoped_ModuleConfig.RepositoryArchive -ChildPath $project.Name)

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($project.Name) Compressed project directory. The project will now be removed from the active project directory."

            Foundry\Remove-Project -Name $PsBoundParameters.Name -Confirm:$false

        } catch {

            $PSCmdlet.ThrowTerminatingError($PSItem)

        }

    }

}