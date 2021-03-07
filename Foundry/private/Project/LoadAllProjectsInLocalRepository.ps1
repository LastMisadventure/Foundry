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

            if (TestIfGitUsed -Project $project) {

                $gitStatus = posh-git\Get-GitStatus -gitDir $project.Paths.GitPath.FullName -ErrorAction Stop

                $project.Branch = $gitStatus.Branch

                $project.RepositoryInitialized = $true

            }

            Write-Output $project

        }

    } catch {

        Write-Error $_

    }

}