<#
.SYNOPSIS
Generates a correct and accurate Magic Quadrant for arbitary products--using the same forumula some leading companies use!!

.DESCRIPTION
Generates a correct and accurate Magic Quadrant for arbitary products--using the same forumula some leading companies use!!

.PARAMETER ProductName
Which product to accurately and very fairly evaluate!

.PARAMETER Title
The title of the Magic Quadrant.

.PARAMETER ResearchContribution
Contribute this many dollars to the 'market research'. No matter how much you spend, the outcome will not change! We "'promise'"!

.EXAMPLE
New-MagicQuadrant -ProductName PowerShell -Title 'Litterally the best at everything!' -ResearchContribution 500000

Magic Quadrant for Litterally the best at everything!
+------------------------------------+------------------------------------+
|Challengers                         |Leaders                             |
|                                    |                                    |
|                                    |                                    |
|                      * PowerShell  |                                    |
|                                    |                                    |
|                                    |         * PowerShell               |
|                                    |                                    |
|                                    |                                    |
|                                    |                                    |
|                                    |                                    |
|                                    |                                    |
|                                    |                                    |
|                                    |                                    |
|                                    |                                    |
+------------------------------------+------------------------------------+
|Niche                               |Visionaries                         |
|                                    |                                    |
|                                    |                                    |
|                                    |            * PowerShell            |
|                                    |                                    |
|                                    |                                    |
|                                    |                                    |
|                                    |                                    |
|                                    |                                    |
|                                    |                                    |
|                                    |                                    |
|                                    |                                    |
|          * PowerShell              |                                    |
|                                    |                                    |
+------------------------------------+------------------------------------+

.NOTES
Thanks to Nathan Smith, from whom I stole this code.
#>
function New-MagicQuadrant {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'low')]

    [OutputType([String])]

    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ProductName,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Title,

        [Parameter(ValueFromPipelineByPropertyName, Position = 2)]
        [ValidateNotNullOrEmpty()]
        [int64]
        $ResearchContributution

    )

    begin {

        function Get-RandXCoord ($width, $Product) {

            $upper = $width - $Product.Length
            Write-Output (Get-Random -Minimum 0 -Maximum $upper)

        }

        function Get-RandYCoord ($height) {

            Write-Output (Get-Random -Minimum 1 -Maximum $height)

        }

        function Get-Line ($i, $x, $y, $word, $quad_title) {

            if ($i -eq 0) {

                $back_pad = $width - $quad_title.Length
                $line = $($quad_title + $(' ' * $back_pad))
            }

            elseif ($i -eq $y) {

                $front_pad = $x
                $back_pad = $width - $word.Length - $front_pad
                $line = $($(' ' * $front_pad) + $word + $(' ' * $back_pad))
            }

            else {
                $line = $blank_line
            }

            Write-Output $line
        }

    }

    process {

        try {

            $word = "* $ProductName"

            [int]$width = $word.Length * 3.0

            if ($width -lt 25) { $width = 25 }

            [int]$height = $width * .4

            $output = ""

            $quadrants = "challengers", "leaders", "niche", "visionaries"

            foreach ($quadrant in $quadrants) {

                New-Variable -Name "$($quadrant)_x" -Value (Get-RandXCoord $width $word) -Force
                New-Variable -Name "$($quadrant)_y" -Value (Get-RandYCoord $height) -Force

            }

            $quad_line = $('-' * ($width))
            $horizontal_line = "+$quad_line+$quad_line+`n"
            $blank_line = $(' ' * ($width))

            if ($Title) { $output += "Magic Quadrant for $Title`n" }

            $output += $horizontal_line

            $i = 0
            do {

                $challengers_line = Get-Line $i $challengers_x $challengers_y $word "Challengers"
                $leaders_line = Get-Line $i $leaders_x $leaders_y $word "Leaders"
                $output += "|$challengers_line|$leaders_line|`n"
                $i++
            }
            while ($i -lt $height)

            $output += $horizontal_line

            $j = 0
            do {

                $niche_line = Get-Line $j $niche_x $niche_y $word "Niche"
                $visionaries_line = Get-Line $j $visionaries_x $visionaries_y $word "Visionaries"
                $output += "|$niche_line|$visionaries_line|`n"
                $j++

            }
            while ($j -lt $height)

            $output += $horizontal_line

            Write-Output ""
            Write-Output ([System.String] $output.Trim())

        }

        catch {

            $PSCmdlet.ThrowTerminatingError($PSitem)

        }

    }

}
