function NewRandomName {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'medium')]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $GenerationData

    )

    process {

        try {

            $tokens = $GenerationData.Parts.Keys | Sort-Object | ForEach-Object {

                $_currentPartMask = $_ + $GenerationData.ThemeMap[$Theme]

                $_currentPartValue = $($GenerationData.DataSource.Where( { $_.Mask -eq $_currentPartMask }).Value | Get-Random)

                Write-Output $_currentPartValue

            }

            $tokens -join ' ' | Write-Output

        } catch {

            $PSCmdlet.ThrowTerminatingError($PSItem)

        }

    }

}