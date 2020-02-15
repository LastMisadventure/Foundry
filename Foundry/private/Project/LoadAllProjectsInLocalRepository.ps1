function LoadAllProjectsInLocalRepository {

    [CmdletBinding(ConfirmImpact = 'low')]

    [OutputType([Project[]])]

    param ()

    try {

        $splat = @{

            Path      = $script:Scoped_ModuleConfig.LocalRepository

            Directory = $true

        }

        Get-ChildItem @splat | ForEach-Object {

            $project = [Project]::New($_)

            $project.IsModule = TestIsModule $project

            if (TestIfGitUsed $project) {

                $project.Branch = GetCurrentGitBranch $project

                $project.RepositoryInitialized = $true

            }

            Write-Output $project

        }

    } catch {

        $PSCmdlet.ThrowTerminatingError($PSItem)

    }

}