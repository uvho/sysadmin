# Define the maximum file size in bytes
$maxFileSize = 2MB

# Define the root directory to search recursively
$rootDirectory = "C:\Example\Path"

# Get all folders that have only one item in them
$foldersToDelete = Get-ChildItem -Path $rootDirectory -Recurse -Directory | Where-Object { 
    (Get-ChildItem -Path $_.FullName -File).Count -eq 1 -and (Get-ChildItem -Path $_.FullName -File).Length -lt $maxFileSize
}

# Prompt the user before deleting each folder
foreach ($folder in $foldersToDelete) {
    $confirmation = Read-Host "Are you sure you want to delete the folder $($folder.FullName)? (Y/N)"
    if ($confirmation -eq "Y") {
        Remove-Item -Path $folder.FullName -Recurse -Force
    }
}
