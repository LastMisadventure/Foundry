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

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Creating repository file: $($_) in $($Project.RepositoryPath)."

            New-Item -ItemType File -Name $_ -Path $Project.RepositoryPath | Out-Null

        }

        NewLicenseFile -Project $Project

        $taskResult = 'Success'

    } catch {

        Write-Error -Exception $_.Exception

    } finally {

        Write-Output $taskResult

    }

}