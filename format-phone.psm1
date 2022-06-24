function format-phone {

    <#
    .SYNOPSIS
        This function is designed to format a mixed string of 1-16 digit numbers as a phone number.
    
    .DESCRIPTION
        This function will take a string of numbers and letters or special characters and output a formatted
        phone number object.  All non-interger characters are stripped out and replaced in the proper place
    
    .PARAMETER InputNumber
        This is the only parameter.  It is the number or string to be formatted
    
    .EXAMPLE
         format-phone -InputNumber +12349215237
    
    .EXAMPLE
         format-phone -InputNumber 1-2349215237
    
    .EXAMPLE
         format-phone -InputNumber 6432215237
    
    .INPUTS
        String
    
    .OUTPUTS
        PSCustomObject
    
    .NOTES
        Author:  Zachary Bonjour
        Website: https://www.linkedin.com/in/zachary-bonjour/
    #>
    
       [CmdletBinding()]
       param (
          [Parameter(Mandatory)]
          [string]$InputNumber
          )

    $OutputNumber  = $InputNumber -replace "[^0-9]"
    $phonearray    = $OutputNumber.ToCharArray()
    $phone_country = $phonearray[-17..-11] -join("")
    $phone_area    = $phonearray[-10..-8] -join("")
    $phone_prefix  = $phonearray[-7..-5] -join("")
    $phone_line    = $phonearray[-4..-1] -join("")

    Switch ($OutputNumber) {
        # 1-4 digits
        {($_.length) -gt 0 -and ($_.length) -lt 5}  {$OutputNumber = $phone_line}

        # 5-7 digits
        {($_.length) -gt 4 -and ($_.length) -lt 8} {$OutputNumber = $phone_prefix + "-" + $phone_line}

        # 8-10 digits
        {($_.length) -gt 7 -and ($_.length) -lt 11} {$OutputNumber = "(" + $phone_area + ")" + " " + $phone_prefix + "-" + $phone_line}

        # more than 10 digits
        {($_.length) -gt 10} {$OutputNumber = "+" + $phone_country + "(" + $phone_area + ")" + " " + $phone_prefix + "-" + $phone_line}
    }

    $OutputObject = [PSCustomObject]@{
        CountryCode  = $phone_country
        AreaCode     = $phone_area
        CityPrefix   = $phone_prefix
        PhoneLine    = $phone_line
        PrettyNumber = $OutputNumber
        PrettyNoIntl = $OutputNumber.Replace(("+" + $phone_country),"")
        PlainNumber  = $OutputNumber -replace "[^0-9]"
    }
    $OutputObject
}