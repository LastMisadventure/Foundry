function NewDynamicParameterDictionary {

    [CmdletBinding(ConfirmImpact = 'low', PositionalBinding, SupportsShouldProcess)]

    [OutputType([System.Management.Automation.RuntimeDefinedParameterDictionary])]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline, Position = 0)]
        [System.Management.Automation.RuntimeDefinedParameter[]]
        $DynamicParameter

    )

    process {

        $spOperation = 'Create a "[System.Management.Automation.RuntimeDefinedParameterDictionary]" object'

        if ($PsCmdlet.ShouldProcess($spOperation)) {

            try {

                $runtimeParameterDictionary = New-Object -ErrorAction Stop -TypeName System.Management.Automation.RuntimeDefinedParameterDictionary

                $DynamicParameter | ForEach-Object {

                    $runtimeParameterDictionary.Add($_.Name, $_)

                }

                Write-Output $runtimeParameterDictionary


            } # end outer try

            catch {

                $PSCmdlet.ThrowTerminatingError($PSItem)

            } # end outer catch

        } # End 'ShouldProcess {}'.

    } # end block 'process'.

    end {

    } # end block 'end'

} # end function 'New-OMTDynamicParameterDictionary'.
