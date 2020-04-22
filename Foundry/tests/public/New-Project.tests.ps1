$moduleName = 'Foundry'

Get-Module $moduleName | Remove-Module -Force

Import-Module $moduleName

InModuleScope $moduleName {

    Describe "public\New-ProjectEstimate" {

        It "When O = 6, N = 12, and P = 24, the Estimate is equal to 13, and uncertainty is equal to 3." {

            $t = @{

                OptimisticEstimate  = 6

                NominalEstimate     = 12

                PessimisticEstimate = 24

            }

            $r = Foundry\New-ProjectEstimate @t

            $r.Duration - $r.uncertainty | should be 10

        }

    }

}
