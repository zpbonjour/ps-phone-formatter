    .SYNOPSIS
        This function is designed to format a mixed string of 1-16 digit numbers as a phone number.
    
    .DESCRIPTION
        This function will take a string of numbers and letters or special characters and output a formatted
        phone number object.  All non-number characters are stripped out and replaced in the proper place
    
    .PARAMETER InputNumber
        This is the only parameter.  It is the number or string to be formatted
    
    .EXAMPLE
         format-phone -InputNumber +12349215237
    
    .EXAMPLE
         (format-phone -InputNumber 1-2349215237).PrettyNumber
    
    .EXAMPLE
         (format-phone -InputNumber 6432215237).AreaCode
    
    .INPUTS
        String
    
    .OUTPUTS
        PSCustomObject
    
    .NOTES
        Author:  Zachary Bonjour
        Website: https://www.linkedin.com/in/zachary-bonjour/
