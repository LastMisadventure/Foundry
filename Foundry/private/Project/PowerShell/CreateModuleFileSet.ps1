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

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Creating module file: $($_) in $($Project.ProjectPath). "

            New-Item -ItemType File -Name $_ -Path $Project.ProjectPath | Out-Null

        }

        CreateModuleManifest $Project

        $taskResult = 'Success'

    } catch {

        Write-Error -Exception $_.Exception

    } finally {

        Write-Output $taskResult

    }

}