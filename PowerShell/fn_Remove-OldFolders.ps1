# Check for and delete folders older than specified number of days
function Remove-OldFolders {
    <#
        .SYNOPSIS
            Searches for files and folders older than a specified number of days
        .DESCRIPTION
            Will run and deleted files/folders with a creation date older than x number of days specified by user
        .EXAMPLE
            (Windows) Remove-OldFolders -FolderLocation c:\scripts\folder -DaysOld 7 [-Verbose]
            Use the Verbose switch to display what folders are being deleted.
        .EXAMPLE
            (OS X) Remove-OldFolders -FolderLocation /Scripts/Folder -DaysOld 14 [-Verbose]
            Use the Verbose switch to display what folders are being deleted.
        .NOTES
            Created 09/24/2018 by Manuel Martinez, Version 1.0
            Updated 09/26/2018 - Corrected proper variable to use in 'Remove-Item' 
            Github: https://www.github.com/manuelmartinez-it
    #>
    [CmdletBinding()]
    param (
        # Folder location to check for files/folders
        [Parameter(
            Mandatory,
            HelpMessage = 'The location to check for files/folders to remove'
        )]
        [String]
        $FolderLocation,

        # Remove files/folders older than this many days
        [Parameter(
            Mandatory,
            HelpMessage = 'Delete files/folders older that this amount of days'
        )]
        [Int32]
        $DaysOld

    )

    $toDelete = Get-ChildItem $FolderLocation | Where-Object {$_.CreationTime -le (Get-Date).AddDays(-$DaysOld)}
    foreach($delete in $toDelete){
        Write-Verbose "Deleting backup folder $delete which was created over $DaysOld days ago"
        Remove-Item -Path "$FolderLocation\$delete" -Recurse -Force -ErrorAction Stop
        Write-Verbose "Successful"
    }

}

