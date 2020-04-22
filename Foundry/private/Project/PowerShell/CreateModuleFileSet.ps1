function CreateModuleFileSet {

    [CmdletBinding(PositionalBinding)]

    param (

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Project]
        $Project

    )

    $taskResult = 'Fail'

    try {

        $name = $Project.Name

        [array] $moduleFiles = ($name + '.psm1')

        $moduleFiles | ForEach-Object {

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Creating module file: $($_) in $($Project.ProjectPath)..."

            New-Item -ItemType File -Name $_ -Path $Project.ProjectPath | Out-Null

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: $($Project.Name): Created module file."

        }

        CreateModuleManifest $Project

        $taskResult = 'Success'

    } catch {

        $PSCmdlet.ThrowTerminatingError($PSItem)

    } finally {

        Write-Output $taskResult

    }

}