function CreateDynamicParameters {

    [CmdletBinding(ConfirmImpact = 'low')]

    param (

    )

    $splat = @{

        Name                            = 'Name'
        ValidateData                    = [Portfolio]::Projects.Name
        ParamTypeName                   = 'system.string'
        Position                        = 1
        ValueFromPipeline               = $true
        ValueFromPipelineByPropertyName = $true
    }

    $script:Scoped_DynamicParams_ProjectNames = NewDynamicParameter @splat

    $psModuleProjects = [Portfolio]::Projects | Where-Object { $_.IsModule -eq $true }

    $splat = @{

        Name                            = 'Name'
        ValidateData                    = $psModuleProjects.Name
        ParamTypeName                   = 'system.string'
        Position                        = 1
        ValueFromPipeline               = $true
        ValueFromPipelineByPropertyName = $true
    }

    $script:Scoped_DynamicParams_PsModuleProjectNames = NewDynamicParameter @splat

}