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

}