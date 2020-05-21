function CreateRepositoryFileSet {

    [CmdletBinding(PositionalBinding)]

    [OutputType([string])]

    param (

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Project]
        $Project

    )

    $taskResult = 'Fail'

    try {

        [array] $repoistoryFileSet = 'ReadMe.md', 'ReleaseNotes.md', '.gitignore'

        $repoistoryFileSet | ForEach-Object {

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Creating repository file: $($_) in $($project.Paths.RepositoryPath)."

            New-Item -ItemType File -Name $_ -Path $project.Paths.RepositoryPath | Out-Null

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Creating repository file: $($_) in $($project.Paths.RepositoryPath)."

        }

        NewLicenseFile -Project $Project

        $taskResult = 'Success'

    } catch {

        $PSCmdlet.ThrowTerminatingError($PSItem)

    } finally {

        Write-Output $taskResult

    }

}