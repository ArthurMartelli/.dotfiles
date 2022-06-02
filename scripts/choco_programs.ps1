# Install chocolatey programs

$programs =
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
"microsoft-windows-terminal",
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

$command = "choco install"

$count = 0

foreach ($item in $programs) {
    $count = $count + 1
    Write-Output ("[{0} - {1}] Installing {2}" -f $count, $programs.Length, $item)
    Invoke-Expression "$command $item"
}