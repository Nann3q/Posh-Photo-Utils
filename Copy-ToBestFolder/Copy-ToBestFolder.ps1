<#
.SYNOPSIS
    Copy all CR2 files listed in supplied .txt to "best" folder
.DESCRIPTION
    This script looks for a .txt list of file names in the selected folder, creates a folder named "Best" and copies all corrsponding CR2 files to the "Best" folder.
.EXAMPLE
    PS C:\> <example usage>
    Explanation of what the example does
.INPUTS
    None
.OUTPUTS
    None
.NOTES
    * User should supply a list of file names to copy in a .txt file named "Best.txt":
        - Naming convention should just be the file's unique ID, so for example a file named "IMG_0181.CR2" should only be listed as "181".
        - The "Best.txt" file should reside in the same directory as the "source" folder (Where files are to be copied from)
        - "Best" folder will be created inside the selected "source" folder, and the listed files will be copied to it.

    * The copy is performed using "RoboCopy.exe", with a (currently hardcoded) default of 16 multiple threads, to allow for a relatively fast paraller copy
     without heavily punishing the computer's resources.
#>

Add-Type -AssemblyName System.Windows.Forms
$FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog 
$FolderBrowser.RootFolder = 'MyComputer'
[void]$FolderBrowser.ShowDialog()
$WorkFolder = $FolderBrowser.SelectedPath

$ListFilePath = "$WorkFolder\Best.txt"
$BestFolder = (New-Item "$WorkFolder\Best" -Type container -Force)

[int]$MaxRecordLegnth = 4
$InvalidFileNames = @()
$ValidFileNames = @()
$Pattern = '[^0-9]'
[string]$ZeroString = '0'
$FileNameExtension = '.CR2'


# Check if List file Exists: 
if (!(Test-Path -Path $ListFilePath)){
                                write-warning "No Batch list File Found!";
                                Pause
                                Exit
                            } 
    
    else {
            Write-Output "List file found: $ListFilePath, Beginning process. . . `n"
         }


# Get an array of records from file list, make sure to fetch only "numbers":
$RawFilesList = Get-Content -Path $ListFilePath | where {[int]::TryParse($_, [ref]0)}


foreach ($Record in $RawFilesList){

                    # Use Regex to get only numerical values from list:
                    $RawFileName = $Record -replace $pattern, ''
                    
                    # Append "IMG_000" (according to name length) to each record, and .CR2 Extension
                    if ($RawFileName.Length -le $MaxRecordLegnth){
                            $ValidFileNames += "IMG_" +  ($ZeroString * ($MaxRecordLegnth - $RawFileName.length)) + $RawFileName + $FileNameExtension
                            
                        }
                  
                        else {
                                $InvalidFileNames += $RawFileName                       
                             }
            }
    


if ($InvalidFileNames.Count -gt 0){
    Write-Output "The following supplied filenames were invalid: $InvalidFileNames `n"
}

Write-Output "Copying:`n $ValidFileNames `nto $BestFolder . . ."

Robocopy.exe $WorkFolder $BestFolder $ValidFileNames /MT 16 /NJH

Write-Output "`nProcess completed, Thank you for using my script! "

