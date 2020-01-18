# Foundry

Provides a set of tools for developing PowerShell Modules. Offers handy integrations with [Visual Studios Code](https://code.visualstudio.com/) and [Git](https://git-scm.com/).

## Projects

The Project is a core concept of this module. You can `Open` (in VSCode), `Create`, `Update`, `Archive`, and `Test` (via [Pester](https://github.com/Pester/Pester) and [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer)) them.

```PowerShell
Name                           Branch         RepositoryPath
----                           ------         --------------
BeExceptional                  (master)       C:\LocalRepos\BeExceptional
Core                           (master)       C:\LocalRepos\Core
Crucible                       (master)       C:\LocalRepos\Crucible
Foundry                        (master)       C:\LocalRepos\Foundry
Hermes                         (master)       C:\LocalRepos\Hermes
Mythos                         (master)       C:\LocalRepos\Mythos
Vault                          (master)       C:\LocalRepos\Vault
Virtuoso                       (master)       C:\LocalRepos\Virtuoso
```

## Getting Started

1. Place the module folder in a directory that's part of `$env:PsModulePath`.

2. Copy the example configuration file and fill it in:

```PowerShell
Copy-Item .\Config.psd1-example .\Config.psd1

code .\Config.psd1

```

3. Import the module forcibly to ensure it has loaded changes to your configuration file (only needed if you've made changes to the `config.psd1` file).

```PowerShell
Import-Module Foundry -Force
```

## Example Operations with Foundry

1. Create a new Project:

```PowerShell
# Create a new module. By default, a git repository is created and the project is automatically opened in VSCode.
New-Project -Name BeExceptional -Type Module -Verbose
```

2. Open an existing Project (in VSCode):

```PowerShell
Open-Project BeExceptional
```

3. Run a Project through the [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer):

```PowerShell
Invoke-CodeAnalyzer BeExceptional
```

4. Update a module's manifest to contain all currently present "public" cmdlets:

```PowerShell
Update-ProjectModuleManifest Crucible
```

5. Test if a module is ready to be released to production (passes all [Pester](https://github.com/Pester/Pester) tests and has no [PSScriptAnalyzer](https://github.com/PowerShell/PSScriptAnalyzer) rule violations):

```PowerShell
Test-ProjectReadyForRelease Core
```
