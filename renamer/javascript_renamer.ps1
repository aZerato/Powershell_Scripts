# renommer l'ensemble des fichiers js 
# afin qu'il soit correctement importé lors du build

# extension
$extensionToCtrl = ".js"
# caractères que l'on veut modifier
$charToChange = '.'
# caractères que l'on veut
$charChange = '-'
# profondeur
$depth = 3

#
# définition de la fonction
#
function RenameJavascriptFiles($folder)
{
    if($depth -ne 0) {
        # 
        $depth = $depth - 1

        # recupération de tous les fichiers/dossiers du dossier passé en param
        $items = Get-ChildItem($folder)
        foreach ($item in $items) 
        {
            # si c'est encore un dossier => récursive
            if($item.Attributes -eq "Directory")
            {
                echo "----- Subfolder " $item.name
                # recursivité
                RenameJavascriptFiles($item.FullName)
            }

            # 
            $extension = [System.IO.Path]::GetExtension($item);
            if($extension -eq $extensionToCtrl) 
            {
                # recuperation du nom du fichier
                $filename = $item.name
                # suppression de l'extension
                $filename = $filename.replace($extensionToCtrl, "")
                # replacement des caractères souhaités
                $filename = $filename.replace($charToChange, $charChange)
                # remise en place de l'extension
                $filename = $filename + $extensionToCtrl
                # on renome en précisant bien le chemin complet via 'FullName'
                Rename-Item -path $item.FullName -NewName $filename

                echo "----- File " $item.name " rename to " $filename
            }
        }
    }
}

#
# Execution
#

# recuperation du path du répertoire courrant
$currentDir = Get-Location
#utilisation de la fonction définie préalablement
RenameJavascriptFiles($currentDir)