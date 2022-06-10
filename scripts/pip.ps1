#Requires -RunAsAdministrator

# Install pip packages

Write-Host "Installing pip packages"

$programs =
"black",
"pdf-cli",
"numpy",
"pandas",
"Django"

$command = "pip install"

$count = 0

foreach ($item in $programs) {
    $count = $count + 1
    Write-Output ("[{0} - {1}] Installing {2}" -f $count, $programs.Length, $item)
    Invoke-Expression "$command $item"
}