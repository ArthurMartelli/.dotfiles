#Requires -RunAsAdministrator

Write-Host "Installing programs with Chocolatey"

# Install chocolatey programs

$choco_programs =
# chocolatey
"chocolatey",
"chocolatey-compatibility.extension",
"chocolatey-core.extension",
"chocolatey-dotnetfx.extension",
"chocolatey-misc-helpers.extension",
"chocolatey-visualstudio.extension",
"chocolatey-windowsupdate.extension",
"dart-sdk",
# programs
"python",
"nodejs",
"rust",
"rustup.install",
"vim",
"wsl2",
"wsl-ubuntu-1804",
"docker-cli",
"docker-desktop",
"sass",
"autohotkey.portable",
"miktex",
"gitkraken",
# CLI apps
"gh",
"curl",
"pandoc",
"speedtest",
"bitwarden-cli",
"marp-cli",
"grep",
# Applications
"googlechrome",
"opera-gx",
"tor-browser",
"vscode",
"steam-client",
"epicgameslauncher",
"discord",
"razer-synapse-3",
"spotify",
"obs-studio",
"gimp",
"zotero",
"7zip",
"unrar",
"unzip",
"microsoft-office-deployment",
"microsoft-teams",
"virtualbox"

$choco_command = "choco install"

$count = 0

foreach ($item in $choco_programs) {
    $count = $count + 1
    Write-Output ("[{0} - {1}] Installing {2}" -f $count, $choco_programs.Length, $item)
    Invoke-Expression "$choco_command $item"
}

# Install chocolatey programs

Write-Host "Installing programs with Winget"

$winget_programs =
"Blitz.Blitz",
"Microsoft.WindowsTerminal"

$winget_command = "choco install"

$count = 0

foreach ($item in $winget_programs) {
    $count = $count + 1
    Write-Output ("[{0} - {1}] Installing {2}" -f $count, $winget_programs.Length, $item)
    Invoke-Expression "$winget_command $item"
}