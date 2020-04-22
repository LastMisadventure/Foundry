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

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Creating repository file: $($_) in $($Project.RepositoryPath)."

            New-Item -ItemType File -Name $_ -Path $Project.RepositoryPath | Out-Null

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Creating repository file: $($_) in $($Project.RepositoryPath)."

        }

        NewLicenseFile -Project $Project

        $taskResult = 'Success'

    } catch {

        $PSCmdlet.ThrowTerminatingError($PSItem)

    } finally {

        Write-Output $taskResult

    }

}