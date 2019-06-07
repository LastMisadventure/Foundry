function CreateNewProject {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    param (

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Request

    )

    $project = [Project]::New((Join-Path -Path $script:Scoped_ModuleConfig.LocalRepository -ChildPath $Request.Name))

    $project.IsModule = $Request.Type -eq 'Module'

    $result = [PSCustomObject][ordered]@{

        CreateRepositoryDirectory = CreateRepositoryDirectory $project

        CreateRepositoryFileSet   = CreateRepositoryFileSet $project

        CreateProjectDirectorySet = CreateProjectDirectorySet $project

        CreateProjectFileSet      = CreateProjectFileSet $project

        CopyVsCodeFileSet         = CopyVsCodeFileSet $project

    }

    if ($Request.Type -eq 'Module') {

        CreateModuleFileSet $project

        UpdatePsModulePath

    }

    if (!$Request.ContainsKey('SkipSourceControlInit')) {

        InitializeSourceControl $project

    }

    if (!$Request.ContainsKey('SkipOpeningNewProject')) {

        $project.Open()

    }

    [Portfolio]::LoadFromRepositoryDirectory()

    Write-Output $result

}