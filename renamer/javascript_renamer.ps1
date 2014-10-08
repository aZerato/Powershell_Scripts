# rename all js files 

# extension
$extensionToCtrl = ".js"
# the char that you to change
$charToChange = '.'
# replacement char
$charChange = '-'
# depth
$depth = 3

#
# Renamer
#
function RenameFiles($folder)
{
    if($depth -ne 0) {
        # 
        $depth = $depth - 1

        # get all files/folder from current folder
        $items = Get-ChildItem($folder)
        foreach ($item in $items) 
        {
            # if already a folder => recursive
            if($item.Attributes -eq "Directory")
            {
                echo "----- Subfolder " $item.name
                # recursive
                RenameJavascriptFiles($item.FullName)
            }

            # 
            $extension = [System.IO.Path]::GetExtension($item);
            if($extension -eq $extensionToCtrl) 
            {
                # get filename
                $filename = $item.name
                # delete extension part
                $filename = $filename.replace($extensionToCtrl, "")
                # replace char(s)
                $filename = $filename.replace($charToChange, $charChange)
                # re-add extension
                $filename = $filename + $extensionToCtrl
                # rename white the full path thanks to 'FullName'
                Rename-Item -path $item.FullName -NewName $filename

                echo "----- File " $item.name " rename to " $filename
            }
        }
    }
}

#
# Execution
#

# current directory location
$currentDir = Get-Location
# use fonction
RenameFiles($currentDir)
