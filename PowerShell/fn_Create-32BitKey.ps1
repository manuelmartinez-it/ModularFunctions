
function Create-32BitKey {
    <#
        .SYNOPSIS
            Creates a 32 bit key to encrypt a password for use in scripts
        .DESCRIPTION
            Used to create a key for use with automation scripts to do basic encryption of password for use in automation scripts
        .EXAMPLE
            (Windows) Create-32BitKey -KeyLocation c:\scripts\folder -KeyName service.vro
        .EXAMPLE
            (OS X) Create-32BitKey -KeyLocation /Scripts/Folder -KeyName service.account
        .NOTES 
            Created 09/26/2018 by Manuel Martinez, Version 1.0
            Github: https://www.github.com/manuelmartinez-it
    #>
    
    [CmdletBinding()]
    param (
        # Location to create the key file
        [Parameter(
            Mandatory,
            HelpMessage = 'Folder location to create key file'
        )]
        [String]
        $KeyLocation,

        # Name of key file to create
        [Parameter(
            Mandatory,
            HelpMessage = 'Name to give the key file'
        )]
        [String]
        $KeyName
    )

    if($IsMacOS){
        $KeyFile = "$KeyLocation/$KeyName.key"
    }
    else {
        $KeyFile = "$KeyLocation\$KeyName.key"
    }
    
    $Key = New-Object Byte[] 32
    [Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($Key)
    $Key | out-file $KeyFile

}