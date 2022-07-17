#Requires -RunAsAdministrator

$message = "Installing Programs"

function install {

    param (
        [Parameter(Mandatory = $true)]
        $packages
    )
    Write-Output $packages.message

    $command = $packages.command
    $count = 0
    $total = $packages.programs.Length

    $q_choices = @(
        [System.Management.Automation.Host.ChoiceDescription]::new("&Yes", "Install this program")
        [System.Management.Automation.Host.ChoiceDescription]::new("Yes to &All", "Install this and all further programs")
        [System.Management.Automation.Host.ChoiceDescription]::new("&No", "Don't install this program")
        [System.Management.Automation.Host.ChoiceDescription]::new("No to A&ll", "Don't install this or any further program")
    )

    $glob_confirm = 0

    foreach ($item in $packages.programs) {

        $count += 1
        $percent = ($count / $total).tostring("P")
        $progress = "($percent) [$count - $total]"
        
        if ($glob_confirm -eq 1) {
            Write-Output ("$progress Installing $item")
            Invoke-Expression "${command} ${item}"
            continue
        }
        
        $q_title = "Installation of $item"
        $q_question = "Do you want to proceed?"
        $decision = $Host.UI.PromptForChoice($q_title, $q_question, $q_choices, 2)
            
        switch ($decision) {
            0 {
                Write-Output ("$progress Installing $item")
                Invoke-Expression "${command} ${item}" 
            }
            1 {
                $glob_confirm = 1
                Write-Output ("$progress Installing $item")
                Invoke-Expression "${command} ${item}"
            }
            2 {
                Write-Output ("$progress Skipping $item")
            }
            3 {
                Write-Output ("Skipping all further installations")
                return
            }
        }
    }
}

$choco = @{
    message  = "Installing programs with Chocolatey"
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
        # CLI apps
        "gh",
        "curl",
        "pandoc",
        "speedtest",
        "bitwarden-cli",
        "marp-cli",
        "grep",
        "sudo"
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
        "virtualbox",
        "revo-uninstaller"
    )
}

$winget = @{
    message  = "Installing programs with Winget"
    command  = "winget install"
    programs = @(
        "Blitz.Blitz",
        "Microsoft.WindowsTerminal",
        "Microsoft.PowerShell",
        "Shiori for Genshin",
        "Microsoft Whiteboard"
    )
}

$pip = @{
    message  = "Installing pip packages"
    command  = "pip install"
    programs = @(
        "black",
        "pdf-cli",
        "numpy",
        "pandas",
        "Django",
        "autopep8",
        "git+https://github.com/ethanavatar/docsgen-py.git" ,
        "gspread",
        "oauth2client"
    )
}

$npm = @{
    message  = "Installing global npm packages"
    command  = "npm install -g"
    programs = @(
        "touch-cli",
        "npm-check-updates"
    )
}

$vscode = @{
    message  = "Installing VSCode extensions"
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

function Main {
    Write-Host $message

    install $choco
    install $winget
    install $pip
    install $npm
    install $vscode
}

Main