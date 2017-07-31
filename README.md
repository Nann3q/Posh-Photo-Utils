# Posh-Photo-Utils
 -------------------------------------------------------------------------------------------------------------------------------
This on-going project consists of a set of bespoke utilities I've created for a photographer to  improve her file management and processing workflows.

Future utilities in this context will be added to this project, as well as improvements / fixes to existing ones.

These utilities are open for use to everyone - but please note that you will be using them under your sole responsibility and at your own discretion.

At this time, they have only been tested on Windows 7 64bit and Windows 10 64bit,
and may work properly only using Powershell version 4.0 or above. 

Please feel free to get in touch if you have any comments, requests etc...
 -------------------------------------------------------------------------------------------------------------------------------

-- Utility no. 1: "Cull-CR2Files.ps1" --

The motivation behind this script, derives from the way the photographer preforms her initial filtering after taking numerous photograps:

Each photograph taken is saved (originally to the Camera's SD Card, later on - to local disk for processing) in both it's full sized "RAW" file (.CR2), and a compressed .JPG File.

Initial filtering is much quicker to do by just previewing all the lighter-weight .JPG files, and deleting all the "bad" images (wrong exposure, out of focus, etc...), after that - all corresponding .CR2 files can be deleted as well, which is what this script takes care of, and saves the manual labour of picking and deleting sometimes hundreds of files:

This script looks for all existing RAW camera files (.CR2) and all JPG files in a given directory 
(Selected by the user upon running the script using a Windows Folder Browser Dialog).

Any CR2 files which have no matching name to a JPG file in this directory enters a "candidate for deletion" list.

Next, the user can go over the list and either approve / not approve each file manually, or the whole list altogether.

Finally, the script will delete all files "approved for deletion" by the user.

![alt tag](https://github.com/Nann3q/Posh-Photo-Utils/blob/master/Cull-CR2Files/ScreenShots/DialogBox.PNG "Screenshot #1: Windows Folder Browser Dialog")


![alt tag](https://github.com/Nann3q/Posh-Photo-Utils/blob/master/Cull-CR2Files/ScreenShots/ApproveList.PNG "Screenshot #2: list of files pending approval")

