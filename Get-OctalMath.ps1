
function Get-OctalMath {
    <#
    .SYNOPSIS
        Returns the decimal value of a given octal along with the mathmatical explanations
    .DESCRIPTION
        With a given octal the decimal output is returned as "Decimal", the initial polynomial is returned as Polynomial and the calculated math string is returned as Math.
    .PARAMETER Octal
        Octal number to return the decimal value and mathmatical equations for 
    .PARAMETER Max
        Returns an object with all values up to the given max int64. Default is 1e10 or 10000000000.
    .EXAMPLE
        Get-OctalMath
    .EXAMPLE
        Get-OctalMath -Octal 37
    .EXAMPLE
        Get-OctalMath -Octal 37,73
    .EXAMPLE
        Get-OctalMath -Max 77
    #>
    param(
        [string[]]$Octal,
        [int64]$Max = 1e10
    )

    # Executable variable for reusable code
    $Output = {
        # Octals only contain numbers from 0-7 so exclude numbers that contain 8 or 9
        if ("$i" -notmatch "8|9") {
            # Convert the octal to a decimal
            $Decimal = $([convert]::ToInt32("$i", 8))

            # Create an array of numbers with the current octal
            $Chars = $i.ToString().ToCharArray()

            # Create blank arrays for math output
            $Poly = @()
            $Math = @()

            # Loop through each number in the character array
            for ($x = 0; $x -lt $Chars.Count; $x++) {
                # Create a string to represent the first object in our equation and append to the Poly array
                $Poly += "($($Chars[$x])*8^$(($Chars.Count-1)-$x))"

                # Get the value of the current set and append to the Math array
                $Math += "$([int][string]$Chars[$x] * [math]::pow(8, $(($Chars.Count - 1) - $x)))"
            }
            
            # Output our values as an object
            [PSCustomObject]@{
                Octal      = "$i"
                Decimal    = $Decimal
                Polynomial = $($Poly -join "+")
                Math       = $("$($Math -join "+")=$Decimal")
            }
        }
    }

    # If octals are defined return only the values for the given octals
    if ($Octal) {
        foreach($i in $Octal) { &$Output }
    }
    else {
        # If not octal is defined list the values up to the max given
        for ($i = 0; $i -le $Max; $i++) {
            &$Output
        }
    }
}