#Requires -RunAsAdministrator

function Install {
    param (
        $packages
    )

    $command = $packages.command

    $count = 0
    $total = $packages.programs.Length
    
    foreach ($item in $packages.programs) {
        $count += 1
        $percent = ($count / $total).tostring("P")

        Write-Output ("($percent) [$count - $total] Installing $item")
        Write-Output "${command} ${item}"
    }
}

$choco = @{ 
    command  = "choco install"
    programs = @(
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
    )
}

$winget = @{
    comand   = "winget install"
    programs = @(
        "Blitz.Blitz",
        "Microsoft.WindowsTerminal",
        "Microsoft.PowerShell",
        "9PH29FZMQK7T"  # Shiori for Genshin
    )
}


$pip = @{
    command  = "pip install"
    programs = @(
        "black",
        "pdf-cli",
        "numpy",
        "pandas",
        "Django",
        "autopep8"
    )
}

$npm = @{
    command  = "npm install -g"
    programs = @(
        "touch-cli"
    )
}

$vscode = @{
    command  = "code --install-extension"
    programs = @(
        "alexcvzz.vscode-sqlite", 
        "bat-snippets.bat-snippets", 
        "batisteo.vscode-django", 
        "chrmarti.regex", 
        "codezombiech.gitignore", 
        "DavidAnson.vscode-markdownlint", 
        "donjayamanne.python-environment-manager", 
        "donjayamanne.python-extension-pack", 
        "eamodio.gitlens", 
        "fnando.linter", 
        "frhtylcn.pythonsnippets", 
        "GitHub.github-vscode-theme", 
        "janisdd.vscode-edit-csv", 
        "KevinRose.vsc-python-indent", 
        "maciejdems.add-to-gitignore", 
        "marcbruederlin.mint-theme", 
        "marp-team.marp-vscode", 
        "mblode.zotero", 
        "ms-azuretools.vscode-docker", 
        "ms-python.python", 
        "ms-python.vscode-pylance", 
        "ms-vscode-remote.remote-containers", 
        "ms-vscode.powershell", 
        "njpwerner.autodocstring", 
        "oderwat.indent-rainbow", 
        "ritwickdey.LiveServer", 
        "sullenor.vscode-transform-case", 
        "tomoki1207.pdf", 
        "Tyriar.lorem-ipsum", 
        "VisualStudioExptTeam.vscodeintellicode", 
        "vscode-icons-team.vscode-icons", 
        "wholroyd.jinja", 
        "yzhang.markdown-all-in-one"
    )
}

Write-Host "Installing programs with Chocolatey"
Install $choco

Write-Host "Installing programs with Winget"
Install $winget

Write-Host "Installing pip packages"
Install $pip

Write-Host "Installing global npm packages"
Install $npm

Write-Host "Installing VSCode extensions"
Install $vscode
