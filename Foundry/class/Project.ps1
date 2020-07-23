class CodeHygieneResult {

    [string] $Project

    [string] $Type

    [bool] $Pass

    [object[]] $Defects

}

class Project {

    [string] $Name

    [string] $Description

    [PSCustomObject] $Paths

    [System.Version] $Version

    [array] $RequiredModules

    [bool] $RepositoryInitialized

    [string] $Branch

    Project ([System.Io.DirectoryInfo] $Directory) {

        $this.Name = $Directory.Name

        $repositoryPath = [System.IO.DirectoryInfo] $Directory.FullName

        $projectPath = [System.IO.DirectoryInfo] (Join-Path -Path $Directory.FullName -ChildPath $Directory.Name)

        $gitPath = [System.IO.DirectoryInfo] (Join-Path -Path $Directory.FullName -ChildPath '.git')

        $testPath = [System.IO.DirectoryInfo] (Join-Path -Path $projectPath.FullName -ChildPath 'tests')

        $manifestPath = [System.IO.FileInfo] (Join-Path -Path $projectPath -ChildPath ("$($Directory.Name)" + '.psd1'))

        $this.Paths = [PSCustomObject] [ordered] @{

            RepositoryPath = $repositoryPath

            ProjectPath    = $projectPath

            GitPath        = $gitPath

            TestPath       = $testPath

            ManifestPath   = $manifestPath

        }

        if (Test-Path -Path $manifestPath) {

            $manifest = Import-PowerShellDataFile -ErrorAction Stop -Path $manifestPath

            $_description = 'No description (please add one!)'

            $manifest | Select-Object -Property Description | Select-Object -ExpandProperty Description | ForEach-Object { $_description = $_ }

            $this.Description = $_description

            $this.Version = $manifest.ModuleVersion

            $this.RequiredModules = GetModuleDepandancy -ErrorAction Stop -Project $this

        }

    }

    [void] Open () {

        code.cmd $this.Paths.RepositoryPath

    }

    [CodeHygieneResult] InvokeCodeAnalyzer () {

        return (InvokePsScriptAnalyzer $this)

    }

    [CodeHygieneResult] InvokeTestSuite () {

        return (InvokePsTestSuite $this)

    }

    [void] UpdateManifest () {

        UpdateModuleManifest $this

    }

    [bool] TestIsReleaseReady () {

        $codeAnalysisResult = $this.InvokeCodeAnalyzer()

        $testSuiteResult = $this.InvokeTestSuite()

        if (($codeAnalysisResult.Pass, $testSuiteResult.Pass) -contains $false) {

            return $false

        } else {

            return $true

        }

    }

}

class ProjectFactory {

    static [object] Create ([hashtable] $Request) {

        return (CreateNewProject $Request)

    }

}

class Portfolio {

    static [Project[]] $Projects

    static LoadFromRepositoryDirectory () {

        [Portfolio]::Projects = LoadAllProjectsInLocalRepository

        CreateDynamicParameters

    }

    static [void] UpdatePsModulePath () {

        UpdatePsModulePath

    }

    static [Project[]] FindAll () {

        return [Portfolio]::Projects

    }

    static [Project] FindOneByNameExact ([string] $Name) {

        return ([Portfolio]::Projects | Where-Object { $_.Name -eq $Name })

    }

    static [Project[]] FindByNameFuzzy ([string] $Name) {

        return ([Portfolio]::Projects | Where-Object { $_.Name -match $Name })

    }

}