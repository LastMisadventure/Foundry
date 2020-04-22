class CodeHygieneResult {

    [string] $Project

    [string] $Type

    [bool] $Pass

    [object[]] $Defects

}

class Project {

    [string] $Name

    [string] $Description

    [System.IO.DirectoryInfo] $RepositoryPath

    [System.IO.DirectoryInfo] $ProjectPath

    [System.IO.DirectoryInfo] $GitPath

    [System.IO.DirectoryInfo] $TestPath

    [bool] $IsModule

    [bool] $RepositoryInitialized

    [string] $Branch

    Project ([System.Io.DirectoryInfo] $Directory) {

        $this.Name = $Directory.Name

        $this.RepositoryPath = $Directory.FullName

        $this.ProjectPath = (Join-Path -Path $Directory.FullName -ChildPath $Directory.Name)

        $this.GitPath = (Join-Path -Path $Directory.FullName -ChildPath ".git")

        $this.TestPath = (Join-Path -Path $this.ProjectPath.FullName -ChildPath "tests")

    }

    [void] Open () {

        code.cmd $this.RepositoryPath

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

        return ([Portfolio]::Projects | Where-Object { $_.Name -like "*$Name*" })

    }

}