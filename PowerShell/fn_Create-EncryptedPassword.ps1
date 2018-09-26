
function Create-EncryptedPassword {
    <#
        .SYNOPSIS
            Encrypts a password using previously created 32Bit Key
        .DESCRIPTION
            Used to create a encrypted password file using 32 bit key for use in automation scripts
        .EXAMPLE
            (Windows) Create-EncryptedPassword -KeyLocation c:\scripts\folder -KeyName service.vro -PwFileLocation c:\scripts\folder -PwFileName service.vro -EncryptPassword MySecretPassword
        .EXAMPLE
            (OS X) Create-EncryptedPassword -KeyLocation /Scripts/Folder -KeyName service.account -PwFileLocation /scripts/folder -PwFileName service.account -EncryptPassword SuperSecretPassword
        .NOTES 
            Created 09/26/2018 by Manuel Martinez, Version 1.0
            Github: https://www.github.com/manuelmartinez-it
    #>
    
    [CmdletBinding()]
    param (
        # Location to retrieve the key file
        [Parameter(
            Mandatory,
            HelpMessage = 'Folder location of the key file to retrieve'
        )]
        [String]
        $KeyLocation,

        # Name of key file to retrieve
        [Parameter(
            Mandatory,
            HelpMessage = 'Name of the key file to retrieve'
        )]
        [String]
        $KeyName,

        # Location to create password file
        [Parameter(
            Mandatory,
            HelpMessage = 'Location to create the password file'
        )]
        [String]
        $PwFileLocation,

        # Name of the password file to create
        [Parameter(
            Mandatory,
            HelpMessage = 'Name to give the password file'
        )]
        [String]
        $PwFileName,

        # Password to encrypt
        [Parameter(
            Mandatory,
            HelpMessage = 'Password to be encrypted'
        )]
        [SecureString]
        $EncryptPassword
    )

    if($IsMacOS){
        $KeyFile = "$KeyLocation/$KeyName.key"
        $PasswordFile = "$PwFileLocation/$PwFileName.txt"
    }
    else {
        $KeyFile = "$KeyLocation\$KeyName.key"
        $PasswordFile = "$PwFileLocation\$PwFileName.txt"
    }

    $Key = Get-Content $KeyFile
    $Password = $EncryptPassword
    $Password | ConvertFrom-SecureString -key $Key | Out-File $PasswordFile
    
}


