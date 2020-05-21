function TestIsModule {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    [OutputType([bool])]

    param (

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Project]
        $Project

    )

    $manifestPath = Join-Path -Path $Project.Paths.ProjectPath -ChildPath ($Project.Name + '.psd1')

    Test-Path -Path $manifestPath -PathType Leaf

}