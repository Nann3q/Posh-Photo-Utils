<#
.SYNOPSIS
    Delete all CR2 Files which have no corresponding JPG file name in a given folder
.DESCRIPTION
    This script looks for all existing RAW camera files (.CR2) and all JPG files in a given directory 
    (Selected by the user upon running the script using a Windows Folder Browser Dialog).

    Any CR2 files which have no matching name to a JPG file in this directory enters a "candidate for deletion" list.

    Next, the user can go over the list and either approve / not approve each file manually, or the whole list altogether.

    Finally, the script will delete all files "approved for deletion" by the user.
.EXAMPLE
    PS C:\>  .\Cull-CR2Files.ps1
    Simply run the script, choose the folder to process in the Windows Folder Browser Dialoge that opens up, and follow instructions.
.INPUTS
    None
.OUTPUTS
    None
.NOTES
    This script is open for everyone to use at their own responsibility and sole discretion.
#>

# Create a Windows Folder Browser Dialog Box:
Add-Type -AssemblyName System.Windows.Forms
$FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog 

# Make sure Dialog Box root is "My Computer":
$FolderBrowser.RootFolder = 'MyComputer'

# Pop the Dialog box for the user to select a working folder for the script's process:
[void]$FolderBrowser.ShowDialog()
$FolderBrowser.SelectedPath

# Make an array of all files in selected folder
$AllFilesArray = Get-ChildItem -Path $FolderBrowser.SelectedPath


        # Didive the main array to 2 sub-arrays, filtered by the files extension:
        $JpgFilesArray = $AllFilesArray | Where-Object {$_.Extension -eq '.jpg'}
        $CR2FilesArray = $AllFilesArray | Where-Object {$_.Extension -eq '.CR2'}

# If there happens to be only 1 or less files in each sub-array, there's no point to run this script.
# Notify the user and exit:
if ($JpgFilesArray.count -lt 1 -or $CR2FilesArray.Count -lt 1) {
        Write-Warning "Looks like there are only 1 or less files of the types you're looking for. Please re-check your folder and try again."
    }


Else {  # Add all CR2 Files with no corresponding jpg files (same name) to a "FilesToDelete" Array:
        $FilesToDelete = Compare-object $CR2FilesArray  $JpgFilesArray -Property BaseName -PassThru

        # Display count of Jpg and CR2 files, as well as a list of all CR2 files pending Deletion:
        Write-Output "$($JpgFilesArray.Count) JPG Files and $($CR2FilesArray.Count) CR2 files were found in $($FolderBrowser.SelectedPath)."
        Write-Output "Here's a list of all files pending deletion: $FilesToDelete `n"

        # Delete extra CR2 Files pending user confirmation
        $FilesToDelete | Remove-Item -Confirm 
    }

    # Let user know process is done:
    Write-Output "`nSelected CR2 Files have been deleted, thank you for using my script!`n"

Pause
Exit